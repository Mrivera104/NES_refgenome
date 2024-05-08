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

Run ANGSD heterozygosity analysis. ANGSD (Analysis of Next Generation Sequencing Data) is a popular software tool used for analyzing NGS (Next Generation Sequencing) data, particularly for population genetics and evolutionary biology studies. ANGSD uses genotype likelihood models to estimate the likelihoods of different genotypes at each genomic locus based on the observed sequencing data. These genotype likelihoods take into account factors such as sequencing depth, base quality scores, and mapping quality scores.

--> INCLUDE ALL SCAFFOLDS: 

    angsd -P 10 -i /scratch1/migriver_CCGP/ncbi_dataset/omnic_mapfiles/SRR25478315_eseal_sorted.bam -anc /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta -dosaf 1 -gl 1 -out SRR25478315_eseal_angsdput -ref /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta
    
    realSFS -fold 1 SRR25478315_eseal_angsdput.saf.idx > SRR25478315_eseal_est.ml

Options: 

    -P 10: Specifies the number of threads or CPUs to use for the analysis. In this case, it sets it to 10 threads, which can speed up the analysis if you have multiple CPU cores available.
    -i: Specifies the input BAM file containing the aligned sequencing reads for analysis.
    -anc: Specifies the ancestral fasta file, which is used as the ancestral reference for certain analyses.
    -dosaf 1: This option specifies that site allele frequencies should be calculated and outputted in SAF format. SAF (Site Allele Frequency) is a file format used for storing allele frequency information at each site in the genome.
    -gl 1: Specifies the genotype likelihood model. In this case, it's using the SAMtools genotype likelihood model, which estimates genotype likelihoods based on sequencing data.
    -fold 1: Specifies that folded SFS (Site Frequency Spectrum) should be calculated. The folded SFS combines allele frequencies of similar frequencies, useful for some population genetic analyses.
    
OR

    bash angsd_gw_het.sh
      
--> BY SCAFFOLD (1-17):
TBD... 


Heterozygosity estimation using R 

I plugged in the generated est.ml file in R using the code found on the ANGSD wikipedia page: http://www.popgen.dk/angsd/index.php/Heterozygosity

    a<-scan("est.ml")
    a[2]/sum(a)

The analysis worked! Using omni-c short read data I was able to get heterozygosity estimates in-line with resequenced individuals. YAY! Genome-wide heterozygosity was calculated at 0.000203. Very low! 


![nucleotide_diversity](https://github.com/Mrivera104/eseal_CCGP/assets/97764650/f2115608-5509-4911-ab60-4f9a793b547c)



# Method 2: Use omni-c data fastq files, QC-check fastq files using fastp, create a BAM file, then use that for genome-wide heterozygosity ANGSD analysis. 

Use fastp to QC the fastq files downloaded from NCBI. 

    bash run_fastp.sh

Output files should be: 

    SRR25478315.fastp.R1.fastq.gz
    SRR25478315.fastp.R2.fastq.gz
The output files are a LOT smaller than the original fastq files O_o well... Anyways. (3G vs. ~60G)

Use Minimap2 for alignment of fastq files to reference genome. 

    minimap2 -ax sr -t 20 /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta /scratch1/migriver_CCGP/ncbi_dataset/omnic_mapfiles/SRR25478315.fastp.R1.fastq.gz /scratch1/migriver_CCGP/ncbi_dataset/omnic_mapfiles/SRR25478315.fastp.R2.fastq.gz | samtools sort -@20 -O BAM -o SRR25478315_eseal_fastp_sorted.bam -

Sort the generated BAM file using samtools

    samtools index SRR25478315_eseal_fastp_sorted.bam

--> INCLUDE ALL SCAFFOLDS: 

    angsd -P 10 -i /scratch1/migriver_CCGP/ncbi_dataset/omnic_mapfiles/SRR25478315_eseal_fastp_sorted.bam -anc /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta -dosaf 1 -gl 1 -out SRR25478315_eseal_angsdput -ref /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta
    
    realSFS -fold 1 SRR25478315_eseal_fastp_angsdput.saf.idx > SRR25478315_eseal_fastp_est.ml
