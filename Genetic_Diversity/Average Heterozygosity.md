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

    bash avg_het.sh

Doing this yielded these results: 

Sample	Heterozygous_sites	Heterozygosity
SRR25478315	537975	0.0002213
![image](https://github.com/user-attachments/assets/7c5df2be-a6ce-4458-8d16-1259560029ef)

This value (average heterozygosity) is much lower than the values I got with ANGSD (genome-wide heterozygosity). I don't know what to make of this, tbh. 

# Calculating Average Genome-Wide Heterozygosity using VCFtools 

I will now do another calculation of genome-wide heterozygosity using VCFtools on scaffolds 1-17 ONLY. I will also do this in windows of 100Kb.

    vcftools --gzvcf SRR25478315_bridgetrim_scaffolds_only.g.vcf.gz --window-pi 100000 --window-pi-step 100000 --out SRR25478315_scaffonly_het_output
I went ahead and transferred that SRR25478315_scaffonly_het_output.windowed.pi into RStudio and wrote a script to visualize pi distributions across the 17 scaffolds only. This is what I got: 0.00023 

I think I'll go ahead and go with this over ANGSD because it makes more sense, given RoH estimates and how variants were visualized across the genome. I'll rewrite this later that didn't make sense lol 
