# Estimating nucleotide diversity of the northern elephant seal and comparing across marine mammal taxa
I performed an extensive literature review of papers that had nucleotide diversity (pi) values for a variety of different marine mammal taxa. I stuck to papers that only used whole-genome sequencing and NOT microsat assays or used mitochondrial genome diversity. These values were kind of hard to find... They only exist for a limited amount of marine mammal taxa, which is more or less expected. A majority of these values came from papers that dealt with cetacean genomics. Some values, however, were retrieved from other previously-compiled nucleotide diversity values, such as Robinson et al 2016 and Morin et al 2020. 

I ended up chosing a VCF file from the available CCGP files that I have available to me on kelpser. Using the metadata, I chose an individual that was also from AN state park. I will come back to this after speaking with Rachel and change it if need be :p probably not the most representative. I should mayve merge all 56 VCF files into one and then run the analyses again. 

code used: 
> vcftools --vcf all_samples.vcf --window-pi  10000 --out all_samples

Tutorial used for estimating nucleotide diversity from a single vcf: https://www-users.york.ac.uk/~dj757/popgenomics/workshop5.html#nucleotide_diversity. I did not deviate from the tutorial and also used a sliding window approach using 10kb windows. 
