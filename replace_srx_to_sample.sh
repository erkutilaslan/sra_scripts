#!/bin/bash

# file containing SRR to sample name mappings
table_file="srx_sample_name.csv"

# loop through each line in the table file
while IFS=',' read -r srx_name sample_name; do

    # find and rename R1 fastq.gz files
    find . -type f -name "${srx_name}_*_1.fastq.gz" | while read -r file; do

        srx_srr=$(basename "$file")
        mv $file ${sample_name}.${srx_srr}
        echo "Renamed $file to ${sample_name}.${srx_srr}"

    done

    # find and rename R2 fastq.gz files if they exist
    find . -type f -name "${srx_name}_*_2.fastq.gz" | while read -r file; do

        srx_srr=$(basename "$file")
        mv $file ${sample_name}.${srx_srr}
        echo "Renamed $file to ${sample_name}.${srx_srr}"

    done

done <"$table_file"
