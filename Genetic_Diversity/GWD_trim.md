# Genomw-Wide Diversity using Trimmed Omni-C Files
(08/02/2024) So after much deliberation, I have decided to trim my Omni-C files for use in downstream analyses. Let's hope this works out! I will be using BWA as my aligner moving forward. 

# Alignment using BWA
First, we have to make sure to index our reference genome

    bwa index 20230202.mMirAng1.NCBI.hap1.fasta 

Align reads to fasta file and create a SAM file

    bwa mem 20230202.mMirAng1.NCBI.hap1.fasta /scratch1/migriver_CCGP/trim_omnic/SRR25478315_trimmed/SRR25478315_1_trimmed.fq /scratch1/migriver_CCGP/trim_omnic/SRR25478315_trimmed/SRR25478315_2_trimmed.fq > SRR25478315_aligned_reads.sam
