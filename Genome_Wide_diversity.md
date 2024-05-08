# Estimating nucleotide diversity of the northern elephant seal and comparing across marine mammal taxa
I performed an extensive literature review of papers that had nucleotide diversity (pi) values for a variety of different marine mammal taxa. I stuck to papers that only used whole-genome sequencing and NOT microsat assays or used mitochondrial genome diversity. These values were kind of hard to find... They only exist for a limited amount of marine mammal taxa, which is more or less expected. A majority of these values came from papers that dealt with cetacean genomics. Some values, however, were retrieved from other previously-compiled nucleotide diversity values, such as Robinson et al 2016 and Morin et al 2020. 

I am approaching this analyses by using omni-c data downloaded from NCBI. The omni-c data for the elephant seal reference genome is short read Illumina data at a higher coverage than what I have for my resequenced individuals. 

Before starting, let's make sure to properly download the files off NCBI using the SRA toolkit that Rachel installed. Yay!
>     fasterq-dump --split-file SRR25478315

I have two strategies for genome-wide heterozygosity: 

# Method 1: Use omni-c data fastq files, create a BAM file, then use that for genome-wide heterozygosity ANGSD analysis. 
