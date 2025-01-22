#!/bin/bash

# Find all .sra files recursively in the current directory and its subdirectories
find . -type f -name '*.sra' | while read -r srr_file; do

    # Extract the base name without the extension
    base_name=$(basename "$srr_file" .sra)

    # Get the directory path of the .sra file
    dir_path=$(dirname "$srr_file")

    echo "Processing $srr_file..."

    # Change directory to where the .sra file is located
    cd "$dir_path" || exit

    # Run fastq-dump with the --split-files option
    fasterq-dump --split-files "$base_name.sra"

    echo "Finished processing $srr_file."

    # Remove the R2 fastq file if it exists
    if [ -f "${base_name}_2.fastq" ]; then
        rm "${base_name}_2.fastq"
        echo "Removed ${base_name}_2.fastq"
    fi

    # Compress the fastq files to fastq.gz
    for fastq_file in "${base_name}"_*.fastq; do
        if [ -f "$fastq_file" ]; then
            pigz "$fastq_file"
            echo "Compressed $fastq_file to ${fastq_file}.gz"
        fi
    done

    # Return to the original directory
    cd - > /dev/null || exit

done

