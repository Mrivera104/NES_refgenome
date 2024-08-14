# Variant Calling and the GATK Pipeline
We need to variant call to be able to perform some additional analyses. 

# Step 1: Map to Genome
The first step to caling variants is to map to the reference genome. we've done that! We have also excluded any unmapped regions in our shiny new bam file. 

The bam file is named:

    SRR25478315_bridgetrim_sorted_only_mapped.bam

# Step 2: The Genome Analysis Toolkit (GATK)
After we have our bam file ready to go, we can use the GATK pipeline for all of our variant calling needs. It is the most popular (maybe, idk) programs for getting genotype calling. 

The first thing we need to do is to mark duplicates using PICARD (comes with the GATK bundle). This marks potential PCR duplicates that may hinder progress in downstream analyses:

    gatk MarkDuplicates -I=/scratch1/migriver_CCGP/trim_omnic/SRR25478315_bridgetrim_sorted_only_mapped.bam -O=SRR25478315_bridgetrim_sorted_duplMarked.bam -M=sorted_duplMarked.metrics
Afterwards, we can organize our bam file in accordance with the GATK guidelines so that the program can actualy read it:

    gatk AddOrReplaceReadGroups -I=SRR25478315_bridgetrim_sorted_duplMarked.bam -O=SRR25478315_bridgetrim_sorted_duplMarked_SM.bam -ID=1 -LB=lib1 -PL=ILLUMINA -PU=unit1 -SM=SRR25478315
Before we proceed, we need to make sure that our fasta file and new bam file are indexed. Let's do that!

    gatk CreateSequenceDictionary -R=20230202.mMirAng1.NCBI.hap1.fasta -O=20230202.mMirAng1.NCBI.hap1.dict
    samtools faidx 20230202.mMirAng1.NCBI.hap1.fasta
    samtools index SRR25478315_bridgetrim_sorted_duplMarked_SM.bam 
Now that we have those files situated, we can go ahead and perform the variant calling process using GATK. This will take a while, so be warned!

    gatk HaplotypeCaller -I SRR25478315_bridgetrim_sorted_duplMarked_SM.bam -R 20230202.mMirAng1.NCBI.hap1.fasta -ERC GVCF -O SRR25478315_bridgetrim.g.vcf.gz
And there you have it! :) yippee






