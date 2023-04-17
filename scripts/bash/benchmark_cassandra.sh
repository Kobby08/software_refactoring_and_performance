#!/bin/bash

# List of commit IDs to checkout to
commit_ids=(
    # "07e5876c43998fe7384df115c65749d668183130"
    # "35dbcc2c2dbe1c826fd6ecd6e8357f0f5a9bab02"
    "4d42c189fa82b32fd93ae42a164b91e4db62992e"
    # "56f24f78f62c9945fae40790e3ed09893fa1ed18"
    "6f90e55e7e23cbe814a3232c8d1ec67f2ff2a537"
    "8ef5a886312e20f09cd4b0358c71018908341796"
    # "93496e826e7382adf52a99d4df38e73a43f892de"
    "9b8692c6a4c75b7df29a58b5d3d1d1ee5cb0c3a4"
    "a7cb009f8a3f4d0e0293111bfcfff3d404a37a89"
    "b32a9e6452c78e6ad08e371314bf1ab7492d0773"
    "c2b635ac240ae8d9375fd96791a5aba903a94498"
    # "d3dadcd6f3bbde471e972f8332eb62de0f2d4aae"
    # "d73f45bad4cd6d8cf1cea7d9b35b76075dc277e1"
    # "e13356d75d2d3c200f1636337cf15329bd1b829b"
    # "e208a6a210d172b991b40fb66a4763e30b3e4d7d"
    "e3f54d4a0c3403141db24f86714c3900eb9f212e"
    "e96b60bd9f814ee1a911e8820b7e255d23e2f24e"
    "f93e6e3401c343dec74687d8b079b5697813ab28"
)
https://repo.maven.apache.org/maven2/org/apache/maven/maven-ant-tasks
# Log file for errors
error_log="$HOME/Desktop/sr/results/cassandra/error_log.txt"

run_benchmark() {
    local commit_id="$1"
    local output_file="$2"

    cd "$HOME/Desktop/sr/cassandra" || return

    # Checkout to the commit ID
    if ! git checkout "$commit_id"; then
        echo -e "Error: failed to checkout to commit $commit_id \n" >>"$error_log"
        return 1
    fi

    if ! ant realclean; then
        echo -e "Error: failed to clean the project for commit $commit_id \n" >>"$error_log"
        # Return to the original commit
        git checkout main
        git reset --hard
        return 1
    fi

    if ! ant build; then
        echo -e "Error: failed to build the project for commit $commit_id \n" >>"$error_log"
        # Return to the original commit
        git checkout main
        git reset --hard
        return 1
    fi

    # if ! ant build-jmh; then
    #     echo -e "Error: failed to build the performance benchmark for commit $commit_id \n" >>"$error_log"
    #     # Return to the original commit
    #     git checkout main
    #     git reset --hard
    #     return 1
    # fi

    # # Go to directory with performance benchmarks
    # if ! cd "tests/performance-jmh"; then
    #     echo -e "Error: failed to enter performance benchmark directory for commit $commit_id \n" >>"$error_log"
    #     # Return to the original commit
    #     git checkout main
    #     git reset --hard
    #     return 1
    # fi

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
    if ! ant microbench >>"$output_file"; then
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
    output_file="$HOME/Desktop/sr/results/cassandra/${commit_id}.txt"

    if ! run_benchmark "$commit_id" "$output_file"; then
        echo "ERROR OCCURED WHILE RUNNING SCRIPT FOR COMMIT $commit_id"
    fi

    prev_commit_id=$(git show "$commit_id^1" --pretty=format:"%H" --no-patch)
    echo "The previous commit ID is: $prev_commit_id"

    if ! run_benchmark "$prev_commit_id" "$output_file"; then
        echo "ERROR OCCURED WHILE RUNNING SCRIPT FOR  PREV COMMIT $prev_commit_id OF CURRENT COMMIT $commit_id"
    fi
    cd "$HOME" || exit

done
