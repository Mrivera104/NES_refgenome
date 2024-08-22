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
# Check trimmed fastq files with FastQC
Let's check how our trimmed fastq files look like before we proceed!

    fastqc SRR25478315_bridgetrim_R1.fastq SRR25478315_bridgetrim_R2.fastq
    xdg-open SRR25478315_bridgetrim_R1.html
    xdg-open SRR25478315_bridgetrim_R2.html




# Align reads to fasta file and create a BAM file
Now, we align the trimmed fastq files to the fasta file. 

    bwa mem -t 80 20230202.mMirAng1.NCBI.hap1.fasta \
    /scratch1/migriver_CCGP/trim_omnic/SRR25478315_trimmed/SRR25478315_bridgetrim_R1.fastq \
    /scratch1/migriver_CCGP/trim_omnic/SRR25478315_trimmed/SRR25478315_bridgetrim_R2.fastq \
    > SRR25478315_bridgetrim_aligned_reads.sam
Afterwards, we can convert the generated SAM file into a BAM file. This saves a lot of space! 

    samtools view -bT 20230202.mMirAng1.NCBI.hap1.fasta SRR25478315_bridgetrim_aligned_reads.sam > SRR25478315_bridgetrim_sorted_aligned_reads.bam
We can now filter unmapped reads and keep only mapped reads in our BAM file. 

    samtools view -h -F 4 -b SRR25478315_bridgetrim_sorted_aligned_reads.bam > SRR25478315_bridgetrim_sorted_only_mapped.bam 

Let's check the coverage of our bam file!

    samtools depth -a SRR25478315_bridgetrim_sorted_only_mapped.bam > coverage.txt
    awk '{sum+=$3} END { print "Average coverage = ",sum/NR}' coverage.txt
# Calculated nucleotide diversity 
We can use ANGSD to calculate nucleotide diversity. Here is the explanation: "The heterozygosity is the proportion of heterozygous genotypes. This is in some sense encapsulated in the theta estimates." http://www.popgen.dk/angsd/index.php/Heterozygosity

From ChatGPT: "The heterozygosity value provided by ANGSD can be interpreted as nucleotide diversity, reflecting the average genetic variation at the nucleotide level across the genome."

    angsd -P 80 -i SRR25478315_bridgetrim_sorted_only_mapped.bam -anc 20230202.mMirAng1.NCBI.hap1.fasta -dosaf 1 -gl 1 -out SRR25478315_eseal_mapped_angsdput -C 50 -ref 20230202.mMirAng1.NCBI.hap1.fasta -minQ 20 -minmapq 30
    realSFS -fold 1 -P 80 SRR25478315_eseal_mapped_angsdput.saf.idx > SRR25478315_eseal_mapped_est.ml

Afterwards, we plug the est.ml file into RStudio and get this output: 0.0006324981



