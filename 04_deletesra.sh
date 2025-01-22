#!/bin/bash

# find all .sra files recursively in the current directory and its subdirectories
find . -type f -name '*.sra' | while read -r srr_file; do

    echo "Deleting $srr_file..."
    rm "$srr_file"
    echo "$srr_file deleted."

done

echo "All .sra files have been deleted."
