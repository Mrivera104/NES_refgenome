# Calculating Runs of Homozygosity (NROH, SROH, and FROH)
To get a better understanding of genetic diversity across the genome of the northern elephant seal, I used VCFtools to help me visualize any potential long runs of homozygosity that are indicative of recent and rampant inbreeding. I feel like my SNP density plots showed long stretches of ROH, but who knows, really. 

First, I estimated runs of homozygosity using the BCFtools ROH option: 

    bcftools roh -G30 --AF-dflt 0.1 SRR25478315_bridgetrim.g.vcf.gz -o SRR25478315_bridgetrim_roh
Next, I isolate only the information I want from the generated file - that is, sample name, chromosome, start position of the ROH, end position, and length (in bp):

    grep "RG" SRR25478315_bridgetrim_roh | cut -f 2,3,4,5,6 > SRR25478315_bridgetrim_roh_RG.txt
Once I have these things, I can read the file into R and output some neat stats. 

       NROH     SROH      FROH
      <int>     <dbl>     <dbl>
       4952    454708179   18.7

NROH - the # of ROH segments in the genome
SROH - the total length of ROH segmenns in the genome in base pairs
FROH - inbreeding coefficient (SROH/total length of genome) 

I've also made a histogram to show the average size of ROH in the northern elephant seal genome: 

![Mirounga ROH Distribution Plot](https://github.com/user-attachments/assets/6ec35b52-338a-44bb-9123-15850e51db91)

Looks like FROH (inbreeding coefficient based on runs of homozygosity) is at 18.7%. This is expected, for the northern elephant seal, owing to their past history of overexploitation. Let's try another way of calculating ROH...


