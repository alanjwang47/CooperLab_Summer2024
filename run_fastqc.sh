#!/bin/bash

# Runs fastqc for all reads in a directory 
# Modified by Alan Wang and ASSISTED WITH CHATGPT

# Define the directory containing the FASTQ files
SAMPLE_DIR="/Users/alanwang/Desktop/COOPERLAB_Summer2024/Pflu_Dicty_20240119"
OUTPUT_DIR="/Users/alanwang/Desktop/COOPERLAB_Summer2024/Pflu_Dicty_20240119_fastqc"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Run FastQC on all compressed FASTQ files in the directory
for fastq_file in "$SAMPLE_DIR"/*.fastq.gz; do
    fastqc -o "$OUTPUT_DIR" "$fastq_file"
done