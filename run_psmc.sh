#!/bin/bash

# Define input and output filenames
INPUT_BAM="/scratch1/migriver_CCGP/PSMC_reseq/A000303/A000303_eseal_sorted.bam"
REFERENCE_FASTA="/scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta.masked"
OUTPUT_PREFIX="A000303_eseal"

# Step 1: Generate input VCF file
bcftools mpileup -Ou -f "$REFERENCE_FASTA" "$INPUT_BAM" | bcftools call -c -Ou | bcftools view -m2 -M2 -v snps -Oz -o "$OUTPUT_PREFIX.vcf.gz"

# Step 2: Convert VCF to PSMC input format
zcat "$OUTPUT_PREFIX.vcf.gz" | vcfutils.pl vcf2fq -d 4 -D 20 | gzip > "$OUTPUT_PREFIX.fq.gz"
psmc fq2psmcfa "$OUTPUT_PREFIX.psmcfa" "$OUTPUT_PREFIX.fq.gz"

# Step 3: Run PSMC analysis
psmc -N25 -t5 -r5 -p "4+25*2+4+6" -o "$OUTPUT_PREFIX.psmc" "$OUTPUT_PREFIX.psmcfa"

# Step 4: Plot PSMC results
psmc_plot.pl -g 4 -u 1e-8 -p "$OUTPUT_PREFIX" "$OUTPUT_PREFIX.psmc"
