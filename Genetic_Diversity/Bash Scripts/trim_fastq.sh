#!/bin/bash

# Directory containing your raw fastq files
INPUT_DIR=/scratch1/migriver_CCGP/ncbi_dataset/omnic_data
# Directory to store the trimmed fastq files
OUTPUT_DIR=/scratch1/migriver_CCGP/ncbi_dataset/omnic_data/trimmed_files
# Number of threads to use
THREADS=4

# Create output directory if it doesn't exist
mkdir -p ${OUTPUT_DIR}

# Loop over all fastq files in the input directory
for FILE in ${INPUT_DIR}/*.fastq
do
    # Get the base name of the file (without path and extension)
    BASENAME=$(basename ${FILE} .fastq)
    
    # Run Trim Galore!
    trim_galore --fastqc --cores ${THREADS} --output_dir ${OUTPUT_DIR} ${FILE}

    echo "Finished trimming ${FILE}"
done

echo "All files processed."
