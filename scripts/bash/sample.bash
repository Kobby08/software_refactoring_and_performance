#!/bin/bash

# List of commit IDs to checkout to
commit_ids=(
    "68f6d8263d8c795722805f0e4d6939e7a8b9ed48"
    # add more commit IDs as needed
)

# # Output file to save benchmark results
# output_file="$HOME/Desktop/sr/results/benchmark_results.txt"

# Log file for errors
error_log="error_log.txt"

# source_path="$HOME/Desktop/sr/src"

# Iterate through the commit IDs and run the benchmark
for commit_id in "${commit_ids[@]}"; do
    output_file="$HOME/Desktop/sr/results/${commit_id}.txt"
    cd "$HOME/Desktop/sr/activemq-artemis" || return

    # Checkout to the commit ID
    git checkout "$commit_id"

    # prev_commit_id=$(git show "$commit_id^1" --pretty=format:"%H" --no-patch)
    # echo "The previous commit ID is: $prev_commit_id"

    # Build the Java project (assuming it's a Maven project)
    mvn clean install -DskipTests

    # Go to directory with performance benchmarks
    cd "tests/performance-jmh" || return

    # Override benchmark mode and other configurations
    cp -Rf ~/Desktop/sr/src .

    # Build performance benchmarks
    mvn clean install -DskipTests

    echo "=========================== BENCHMARK RESULTS FOR $commit_id ====================================" >>"$output_file"
    # Run the JMH benchmark and save the results to a file
    java -jar target/benchmarks.jar >>"$output_file"

    # Return to the original commit
    git checkout main

    cd "$HOME" || return
done

echo 'We are done...'

run_benchmark() {
    local commit_id="$1"
    local output_file="$2"

    # Checkout to the commit ID
    if ! git checkout "$commit_id"; then
        echo "Error: failed to checkout to commit $commit_id" >>"$error_log"
        return 1
    fi

    # Build the Java project (assuming it's a Maven project)
    if ! mvn clean install -DskipTests; then
        echo "Error: failed to build the project for commit $commit_id" >>"$error_log"
        return 1
    fi

    # Go to directory with performance benchmarks
    if ! cd "tests/performance-jmh"; then
        echo "Error: failed to enter performance benchmark directory for commit $commit_id" >>"$error_log"
        return 1
    fi

    # Override benchmark mode and other configurations
    if ! cp -Rf ~/Desktop/sr/src .; then
        echo "Error: failed to copy overrides for commit $commit_id" >>"$error_log"
        return 1
    fi

    # Build performance benchmarks
    if ! mvn clean install -DskipTests; then
        echo "Error: failed to build the benchmarks for commit $commit_id" >>"$error_log"
        return 1
    fi

    # Run the JMH benchmark and save the results to a file
    echo "=========================== BENCHMARK RESULTS FOR $commit_id ====================================" >>"$output_file"
    # Run the JMH benchmark and save the results to a file
    if ! java -jar target/benchmarks.jar >>"$output_file"; then
        echo "Error: failed to run the benchmark" >>"$error_log"
        return 1
    fi

}
