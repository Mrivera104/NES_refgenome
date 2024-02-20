# Estimating nucleotide diversity of the northern elephant seal and comparing across marine mammal taxa
I performed an extensive literature review of papers that had nucleotide diversity (pi) values for a variety of different marine mammal taxa. I stuck to papers that only used whole-genome sequencing and NOT microsat assays or used mitochondrial genome diversity. These values were kind of hard to find... They only exist for a limited amount of marine mammal taxa, which is more or less expected. A majority of these values came from papers that dealt with cetacean genomics. Some values, however, were retrieved from other previously-compiled nucleotide diversity values, such as Robinson et al 2016 and Morin et al 2020. 

I ended up chosing a VCF file from the available CCGP files that I have available to me on kelpser. Using the metadata, I chose an individual that was also from AN state park. I will come back to this after speaking with Rachel and change it if need be :p probably not the most representative. I should mayve merge all 56 VCF files into one and then run the analyses again. 

code used: 
> vcftools --vcf all_samples.vcf --window-pi  10000 --out all_samples

Tutorial used for estimating nucleotide diversity from a single vcf: https://www-users.york.ac.uk/~dj757/popgenomics/workshop5.html#nucleotide_diversity. I did not deviate from the tutorial and also used a sliding window approach using 10kb windows. 

My next step will be to concatenate all .vcf files into one large .vcf file of all n. elephant seals across their range using the following code: 
>gatk CombineGVCFs -R /scratch1/migriver_CCGP/20230202.mMirAng1.NCBI.hap1.fasta \
--variant A000279_A005_9C.g.vcf.gz \
--variant A000310_A006_12C.g.vcf.gz \
--variant A000253_A005_6A.g.vcf.gz \
--variant A000280_A005_9D.g.vcf.gz \
--variant A000311_A006_12D.g.vcf.gz \
--variant A000254_A005_6B.g.vcf.gz \
--variant A000281_A005_9E.g.vcf.gz \
--variant A000312_A006_12E.g.vcf.gz \
--variant A000256_A005_6D.g.vcf.gz \
--variant A000282_A005_9F.g.vcf.gz \
--variant A000313_A006_12F.g.vcf.gz \
--variant A000258_A005_6F.g.vcf.gz \
--variant A000283_A005_9G.g.vcf.gz \
--variant A000314_A006_12G.g.vcf.gz \
--variant A000259_A005_6G.g.vcf.gz \
--variant A000284_A005_9H.g.vcf.gz \
--variant A000315_A006_12H.g.vcf.gz \ 
--variant A000260_A005_6H.g.vcf.gz \
--variant A000286_A005_10B.g.vcf.gz \
--variant A000316_A007_11F.g.vcf.gz \
--variant A000261_A005_7A.g.vcf.gz \
--variant A000288_A005_10D.g.vcf.gz \
--variant A000317_A007_11G.g.vcf.gz \
--variant A000262_A005_7B.g.vcf.gz \
--variant A000290_A005_10F.g.vcf.gz \
--variant A000318_A007_11H.g.vcf.gz \
--variant A000266_A005_7F.g.vcf.gz \
--variant A000291_A005_10G.g.vcf.gz \
--variant A000319_A007_12A.g.vcf.gz \
--variant A000268_A005_7H.g.vcf.gz \
--variant A000293_A005_11A.g.vcf.gz \
--variant A000320_A007_12B.g.vcf.gz \
--variant A000269_A005_8A.g.vcf.gz \
--variant A000294_A005_11B.g.vcf.gz \
--variant A000321_A007_12C.g.vcf.gz \
--variant A000270_A005_8B.g.vcf.gz \
--variant A000299_A005_11G.g.vcf.gz \
--variant A000322_A007_12D.g.vcf.gz \
--variant A000271_A005_8C.g.vcf.gz \
--variant A000300_A005_11H.g.vcf.gz \
--variant A000323_A007_12E.g.vcf.gz \
--variant A000272_A005_8D.g.vcf.gz \
--variant A000302_A005_12B.g.vcf.gz \
--variant A000324_A007_12F.g.vcf.gz \
--variant A000273_A005_8E.g.vcf.gz \
--variant A000303_A005_12C.g.vcf.gz \
--variant A000325_A007_12G.g.vcf.gz \
--variant A000274_A005_8F.g.vcf.gz \
--variant A000306_A005_12F.g.vcf.gz \
--variant A000326_A007_12H.g.vcf.gz \
--variant A000277_A005_9A.g.vcf.gz \
--variant A000308_A005_12H.g.vcf.gz \
--variant A000278_A005_9B.g.vcf.gz \
--variant A000309_A006_12B.g.vcf.gz \
-O eseal_whole_range.vcf.gz
