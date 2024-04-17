# PSMC Analysis on M. agunstirostris Reference Genome
Documentation began on  02/14/2024 (Valentine's Day!!!!!!!). I will be running a PSMC model analysis on the northern elephant seal (Mirounga angustirostris) CCGP reference genome. This will (hopefully) allow me to look at how demography/effective population size has changed throughout time. 

# Notes
I will be using the NES hap1 fasta to map all of my files to. 

Originally, I thought about mapping the hap2 fasta to hap1 to use for my PSMC analyses. The first couple times I've tried it hasn't worked, but I think I may have found a work around it... 

I am currently making a repeat-masked version of my hap1 fasta file - I will be using this version to do three analyses: 1.) map my highest-coverage resequenced individual (QC'd using fastp) to the repeat-masked fasta 2.) map the hap2 fasta to the repeat-masked hap1 fasta 3.) map the hap2 Omni-C data to the hap1 repeat-masked fasta. 

I really hope one of these will work. I am crying ...

# create conda environment 
    conda create --name eseal python=3.4
    activate eseal

# check environments 
    conda env list
    conda info

# installing packages 
    conda instal bioconda::samtools
    conda install bioconda::bcftools
    conda install bioconda::gatk4
    conda install bioconda::picard

# Create an index for our fasta file 
    samtools faidx /scratch1/migriver_CCGP/PSMC/refs/20230202.mMirAng1.NCBI.hap1.fasta

output is: 20230202.mMirAng1.NCBI.hap1.fasta.fai

# Mask repeats in our fasta file 
    RepeatMasker -species mammals /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta 

 had to install repeatmasker using conda because the base repeatmasker wasnt working ... thats fine
 
# Method 1
1.) map my highest-coverage resequenced individual (QC'd using fastp) to the repeat-masked fasta

fastp code used: 
>        eseal_fastp.sh

2.) Align QC'd fastq files to repeat-masked fasta file and create a BAM file 
>     minimap2 -ax sr -t 20 /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta.masked /scratch1/migriver_CCGP/fastp/A000303_A005_12C_S2_L004.fastp.R1.fastq.gz /scratch1/migriver_CCGP/fastp/A000303_A005_12C_S2_L004.fastp.R2.fastq.gz | samtools sort -@20 -O BAM -o A000303_eseal_sorted.bam -

Explanation:

3.) Index the .BAM file using samtools 

# Method 2


