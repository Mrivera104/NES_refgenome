# Genomw-Wide Diversity using Trimmed Omni-C Files
(08/02/2024) So after much deliberation, I have decided to trim my Omni-C files for use in downstream analyses. Let's hope this works out! I will be using BWA as my aligner moving forward. 

# Alignment using BWA
First, we have to make sure to index our reference genome

    bwa index 20230202.mMirAng1.NCBI.hap1.fasta 

# Proper trimming of Omni-C files 
For Omni-C files, you need to properly trim bridge sequences used during library prep. More details here: https://omni-c.readthedocs.io/en/latest/assembly.html

    cutadapt -j 16 \
    -b GGTTCGTCCA \
    -B GGTTCGTCCA \
    -o SRR25478315_bridgetrim_R1.fastq \
    -p SRR25478315_bridgetrim_R2.fastq \
    /scratch1/migriver_CCGP/ncbi_dataset/omnic_data/SRR25478315_1.fastq \
    /scratch1/migriver_CCGP/ncbi_dataset/omnic_data/SRR25478315_2.fastq

# Align reads to fasta file and create a BAM file
Now, we align the trimmed fastq files to the fasta file. 

    bwa mem -t 80 20230202.mMirAng1.NCBI.hap1.fasta \
    /scratch1/migriver_CCGP/trim_omnic/SRR25478315_trimmed/SRR25478315_bridgetrim_R1.fastq \
    /scratch1/migriver_CCGP/trim_omnic/SRR25478315_trimmed/SRR25478315_bridgetrim_R2.fastq \
    > SRR25478315_bridgetrim_aligned_reads.sam
Afterwards, we can convert the generated SAM file into a BAM file. This saves a lot of space! 

    samtools view -bT 20230202.mMirAng1.NCBI.hap1.fasta SRR25478315_bridgetrim_aligned_reads.sam > SRR25478315_bridgetrim_sorted_aligned_reads.bam




