#!/bin/bash

# List of commit IDs to checkout to
commit_ids=(
    "1a9426cca72d0eaed409898e389436d44cd62f9d"
    "2db5c65f18ceae27725e3fed1d09b35a362cdd84"
    "32c57298a36036328cb87a57f105f39ce3fc45d7"
    "3b2447a623a673f5070ce2b26edc87dfde03d5a7"
    "41b8a3999803673eeda884b9568243072882e8a1"
    "46b56d0730cde6f0a653766aaec938fabacda25d"
    "4c5fa2f456eb3ea431e3764a813833eeea16bc32"
    "5eb21f82a46e2193c03e2af14cc1b075dc69fde3"
    "613612dbf0abb2f77b756a704f20e87b6d0e9807"
    "675ff02455ff27ed280ed952aafb30c8f2d25db8"
    "93c807d6128d1ca06268dd5f96cc161b57bec8b7"
    "a729b8c78a2dd52e15098e9d1afd0e130d87c9af"
    "b2101f6390e4bed2c84e200cf57e90f118714670"
    "df1b9ce81e6bf35510e3789b469e712e471e31ba"
    "df966279feebce96eff6531668bf2f5c594fcc91"
    "ed4c65547f21694ccd693c21a270dbe057f21ad7"
    "ee76fb8224c479fa921104dacbd4ecae5708f35e"
)

# Log file for errors
error_log="$HOME/Desktop/sr/results/error_log.txt"

run_benchmark() {
    local commit_id="$1"
    local output_file="$2"

    cd "$HOME/Desktop/sr/activemq-artemis" || return

    # Checkout to the commit ID
    if ! git checkout "$commit_id"; then
        echo -e "Error: failed to checkout to commit $commit_id \n" >>"$error_log"
        return 1
    fi

    # Build the Java project (assuming it's a Maven project)
    if ! mvn clean install -DskipTests; then
        echo -e "Error: failed to build the project for commit $commit_id \n" >>"$error_log"
        # Return to the original commit
        git checkout main
        git reset --hard
        return 1
    fi

    # Go to directory with performance benchmarks
    if ! cd "tests/performance-jmh"; then
        echo -e "Error: failed to enter performance benchmark directory for commit $commit_id \n" >>"$error_log"
        # Return to the original commit
        git checkout main
        git reset --hard
        return 1
    fi

    # Override benchmark mode and other configurations
    # if ! cp -Rf ~/Desktop/sr/src .; then
    #     echo -e "Error: failed to copy overrides for commit $commit_id \n" >>"$error_log"
    #     # Return to the original commit
    #     git checkout main
    #     git reset --hard
    #     return 1
    # fi

    # # Build performance benchmarks
    # if ! mvn clean install -DskipTests; then
    #     echo -e "Error: failed to build the benchmarks for commit $commit_id \n" >>"$error_log"
    #     # Return to the original commit
    #     git checkout main
    #     git reset --hard
    #     return 1
    # fi

    # Run the JMH benchmark and save the results to a file
    echo -e "\n =========================== BENCHMARK RESULTS FOR $commit_id ==================================== \n" >>"$output_file"
    # Run the JMH benchmark and save the results to a file
    if ! java -jar target/benchmark.jar >>"$output_file"; then
        echo -e "Error: failed to run the benchmark for commit $commit_id \n" >>"$error_log"
        # Return to the original commit
        git checkout main
        git reset --hard
        return 1
    fi

    git reset --hard
    # Return to the original commit
    git checkout main

}

# Iterate through the commit IDs and run the benchmark
for commit_id in "${commit_ids[@]}"; do
    output_file="$HOME/Desktop/sr/results/${commit_id}.txt"

    if ! run_benchmark "$commit_id" "$output_file"; then
        echo "Error occurred while running benchmark for commit $commit_id"
    fi

    prev_commit_id=$(git show "$commit_id^1" --pretty=format:"%H" --no-patch)
    echo "The previous commit ID is: $prev_commit_id"

    if ! run_benchmark "$prev_commit_id" "$output_file"; then
        echo "Error occurred while running benchmark for previous commit $prev_commit_id of current commit $commit_id"
    fi
    cd "$HOME" || exit

done
