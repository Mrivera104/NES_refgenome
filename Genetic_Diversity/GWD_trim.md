# Genomw-Wide Diversity using Trimmed Omni-C Files
(08/02/2024) So after much deliberation, I have decided to trim my Omni-C files for use in downstream analyses. Let's hope this works out! I will be using BWA as my aligner moving forward. 

# Alignment using BWA
First, we have to make sure to index our reference genome

    bwa index 20230202.mMirAng1.NCBI.hap1.fasta 

When I first tried to align reads, I received this error:  [mem_sam_pe] paired reads have different names: "SRR25478315.9989", "SRR25478315.9990". This means that the paired-end fastq files don't have appropriate matching names and this discrepency makes alignment impossible. I did some research and found that I can use a tool from BBMap to deal with organizing the read names:

    repair.sh in1=SRR25478315_1_trimmed.fq in2=SRR25478315_2_trimmed.fq out1=SRR25478315_1_trimmed_fixed.fq out2=SRR25478315_2_trimmed_fixed.fq

Align reads to fasta file and create a SAM file

    bwa mem 20230202.mMirAng1.NCBI.hap1.fasta /scratch1/migriver_CCGP/trim_omnic/SRR25478315_trimmed/SRR25478315_1_trimmed.fq /scratch1/migriver_CCGP/trim_omnic/SRR25478315_trimmed/SRR25478315_2_trimmed.fq > SRR25478315_aligned_reads.sam
