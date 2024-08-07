#!/bin/bash

# Runs breseq for all paired reads in a directory 
# Modified by Alan Wang and ASSISTED WITH CHATGPT

# Define the directory containing the sample files and the reference genome
SAMPLE_DIR="/net/dali/home/mscbio/alanwang/input_reads/clonal_reads(already done)/"
REFERENCE_GENOME="/net/dali/home/mscbio/alanwang/sbw25_reference.gbff"


# Iterate over each forward read file in the sample directory
for forward_read in "$SAMPLE_DIR"/*_R1_*.fastq.gz; do

    # Extract the base name of the forward read file
    base_name=$(basename "$forward_read" _R1_001.fastq.gz)

    # Get the corresponding reverse read file name
    reverse_read="${SAMPLE_DIR}/${base_name}_R2_001.fastq.gz"

    # Create output directory to put each run's files into
    OUTPUT_DIR="/net/dali/home/mscbio/alanwang/breseq_outputs/Pflu_Dicty_exp1/${base_name}"
    mkdir -p "$OUTPUT_DIR"

    # Run breseq on the paired-end reads
    breseq -r "$REFERENCE_GENOME" \
            -j 3 \
            -p \
            -o "$OUTPUT_DIR" \
            "$forward_read" \
            "$reverse_read"

done