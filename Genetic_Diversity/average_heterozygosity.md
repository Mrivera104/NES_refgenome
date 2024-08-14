# Calculating Average Heterozygosity using VCFTools 
I decided to calculate average heterozygosity in more ways than just ANGSD, because I feel that my ANGSD output isn't necessarily correct. I used a script from the SMSC conservation genomics course I took back in 2023. 

    #!/bin/bash

    #Replace these with the actual file names
    VCF_FILE="/scratch1/migriver_CCGP/trim_omnic/variant_call/SRR25478315_bridgetrim.g.vcf.gz"
    OUTPUT_FILE="eseal_heterozygosity_v5.tsv"
    GENOME_LENGTH=2430321998

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

name it and run the script:

    bash avg_heterozygosity.sh

Doing this yielded these results: 

Sample	Heterozygous_sites	Heterozygosity
SRR25478315	537975	0.0002213
![image](https://github.com/user-attachments/assets/7c5df2be-a6ce-4458-8d16-1259560029ef)

This value (average heterozygosity) is much lower than the values I got with ANGSD (genome-wide heterozygosity). I don't know what to make of this, tbh. 
