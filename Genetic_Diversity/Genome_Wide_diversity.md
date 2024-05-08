# Estimating nucleotide diversity of the northern elephant seal and comparing across marine mammal taxa
I performed an extensive literature review of papers that had nucleotide diversity (pi) values for a variety of different marine mammal taxa. I stuck to papers that only used whole-genome sequencing and NOT microsat assays or used mitochondrial genome diversity. These values were kind of hard to find... They only exist for a limited amount of marine mammal taxa, which is more or less expected. A majority of these values came from papers that dealt with cetacean genomics. Some values, however, were retrieved from other previously-compiled nucleotide diversity values, such as Robinson et al 2016 and Morin et al 2020. 

I am approaching this analyses by using omni-c data downloaded from NCBI. The omni-c data for the elephant seal reference genome is short read Illumina data at a higher coverage than what I have for my resequenced individuals. 

Before starting, let's make sure to properly download the files off NCBI using the SRA toolkit that Rachel installed. Yay!
      
    fasterq-dump --split-file SRR25478315

I have two strategies for genome-wide heterozygosity: 

# Method 1: Use omni-c data fastq files, create a BAM file, then use that for genome-wide heterozygosity ANGSD analysis. 
Use Minimap2 for alignment of fastq files to reference genome. (In this case, I am using the unmasked reference genome since we are running out of room for temp files on kelpser currently. I will try this some other time). Minimap2 is a versatile alignment program that aligns DNA or mRNA sequences against a large reference database.

    minimap2 -ax sr -t 20 /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta /scratch1/migriver_CCGP/ncbi_dataset/omnic_data/SRR25478315_1.fastq /scratch1/migriver_CCGP/ncbi_dataset/omnic_data/SRR25478315_2.fastq | samtools sort -@20 -O BAM -o SRR25478315_eseal_sorted.bam -

Options:

    -a: Output in the SAM format (Sequence Alignment/Map format), which is a standard format for storing read alignments to a reference genome.
    -x sr: This specifies the preset alignment mode. sr stands for "long-read alignment."
    -t 20: This specifies the number of threads or CPU cores to be used during the alignment process. In this case, it's set to 20, meaning the alignment process will utilize 20 CPU cores in parallel, which can speed up the alignment process significantly on multicore systems.
    -@ 20: This specifies the number of threads or CPU cores to be used by samtools sort. Similar to -t in minimap2, this sets the number of threads to 20.

Sort the generated BAM file using samtools

    samtools index SRR25478315_eseal_sorted.bam

--> INCLUDE ALL SCAFFOLDS: 

    angsd -P 10 -i /scratch1/migriver_CCGP/ncbi_dataset/omnic_mapfiles/SRR25478315_eseal_sorted.bam -anc /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta -dosaf 1 -gl 1 -out SRR25478315_eseal_angsdput -ref /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta
    
    realSFS -fold 1 SRR25478315_eseal_angsdput.saf.idx > SRR25478315_eseal_est.ml
    
OR

    bash angsd_gw_het.sh
      
--> BY SCAFFOLD (1-17):
