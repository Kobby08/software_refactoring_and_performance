#!/bin/bash

# List of commit IDs to checkout to
commit_ids=(
    # "1392cb5f0b669129b5ba54714d1d8b0b0a00a77c"
    # "2105479304a7efead14ecb343686bf31042f1731"
    # "270b383e80296fb47dba6a719ef1616ddcaab1ef"
    # "27cfb2d90208403cec6727dd595f9dd1380ef441"
    # "3a5971ec81984a091123c21fd1b9ac6e777fc7cf"
    # "3fd9fbe2d0b8e9e1b29c31e6472da192e12329f6"
    # "54752a9cedcceef9715345730eae4766be2c8458"
    # "583bd3602a62af0b80676c7677d81affc80fe6ef"
    # "68f6d8263d8c795722805f0e4d6939e7a8b9ed48"
    "858a8240f97f7cd2fc3bca052ff74a97c0bf886c"
    "89e0c461e5128768513943e60f6e3992f066f529"
    "8e40b2d4f4f242271d3dfcda4f9b96d3f94cee1b"
    "dd052026e6c5616f1f51795ea21d26f12deaf9e7"
    "fafbd7e2e5953e03573088577be620828cd77bc5"
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
    if ! cp -Rf ~/Desktop/sr/src .; then
        echo -e "Error: failed to copy overrides for commit $commit_id \n" >>"$error_log"
        # Return to the original commit
        git checkout main
        git reset --hard
        return 1
    fi

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

    # Return to the original commit
    git checkout main
    git reset --hard

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
