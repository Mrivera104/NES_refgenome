#!/bin/bash

#Replace these with the actual file names
VCF_FILE="/pool/genomics/figueiroh/SMSC_2023_class/vcf/NN_6samples_HD_PASS_DP5.vcf.gz"
OUTPUT_FILE="NN_heterozygosity_v5.tsv"
GENOME_LENGTH=2468345093 #you can use the fasta index (.fai) to sum the total length of the genome

#Get a list of sample names from the VCF file
SAMPLES=$(bcftools query -l $VCF_FILE)

#Write a header line to the output file
echo -e "Sample\tHeterozygous_sites\tHeterozygosity" > $OUTPUT_FILE

#Loop through each sample and calculate the heterozygosity
for SAMPLE in $SAMPLES; do
  HETEROZYGOUS=$(bcftools view -s $SAMPLE $VCF_FILE | grep -v "#" | grep -o "0/1" | wc -l)
  HETEROZYGOSITY=$(echo "scale=7; $HETEROZYGOUS / $GENOME_LENGTH" | bc)
  echo -e "$SAMPLE\t$HETEROZYGOUS\t$HETEROZYGOSITY" >> $OUTPUT_FILE
done
