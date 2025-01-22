#!/bin/bash

# file containing SRR to sample name mappings
table_file="SRA_samplenames.csv"

# loop through each line in the table file
while IFS=',' read -r srr_name sample_name; do

    echo "Processing $srr_name -> $sample_name"

    # find and rename R1 fastq files
    find . -type f -name "${srr_name}_1.fastq" | while read -r file; do

        dir=$(dirname "$file")
        mv $file ${dir}/${sample_name}_R1.fastq
        echo "Renamed $file to ${dir}/${sample_name}_R1.fastq"

    done

    # find and rename R2 fastq files if they exist
    find . -type f -name "${srr_name}_2.fastq" | while read -r file; do

        dir=$(dirname "$file")
        mv $file ${dir}/${sample_name}_R2.fastq
        echo "Renamed $file to ${dir}/${sample_name}_R2.fastq"

    done

done < "$table_file"

