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

# Calculating ROH using PLINK 

Now I'm gonna pivot to using PLINK to run the same analysis and see what happens.

Step 1: Convert VCF to PLINK format. PLINK needs files from VCFs formatted in a specific way (I need to do more research on what PLINK does...) 

    plink --vcf /scratch1/migriver_CCGP/trim_omnic/variant_call/SRR25478315_bridgetrim.g.vcf.gz --allow-extra-chr  --make-bed --out eseal_bfile

Step 2: Run ROH analysis with appropriate settings

    plink --bfile eseal_bfile --allow-extra-chr --homozyg --homozyg-snp 50 --homozyg-kb 100 --homozyg-density 50 --homozyg-gap 1000 --homozyg-window-snp 50 --homozyg-window-het 1 --homozyg-window-missing 5 --homozyg-het 1 --homozyg-group --out eseal_roh
As you can see, these settings are a lot more stringent. Here is what they mean (THANKS CHATGPT): 

    plink --bfile eseal_bfile \
      # --bfile: specifies the input binary fileset (BED, BIM, and FAM files) with the base name 'eseal_bfile'.
      
      --allow-extra-chr \
      # --allow-extra-chr: allows the use of non-standard chromosome names, which might be necessary if your data includes scaffolds or non-human chromosomes.
      
      --homozyg \
      # --homozyg: initiates the ROH analysis.
      
      --homozyg-snp 50 \
      # --homozyg-snp 50: requires that each ROH must contain at least 50 SNPs to be considered valid.
      
      --homozyg-kb 100 \
      # --homozyg-kb 100: requires that each ROH must span at least 100 kilobases (kb) in length to be considered valid.
      
      --homozyg-density 50 \
      # --homozyg-density 50: specifies that within any ROH, there must be an average of at least one SNP every 50 kb.
      
      --homozyg-gap 1000 \
      # --homozyg-gap 1000: allows a gap of up to 1000 kb (1 Mb) between consecutive SNPs in an ROH. If the gap between two SNPs exceeds this value, the ROH is broken.
      
      --homozyg-window-snp 50 \
      # --homozyg-window-snp 50: the sliding window will analyze 50 SNPs at a time to check for homozygosity.
      
      --homozyg-window-het 1 \
      # --homozyg-window-het 1: allows a maximum of 1 heterozygous SNP within the sliding window before it is excluded from the ROH.
      
      --homozyg-window-missing 5 \
      # --homozyg-window-missing 5: allows up to 5 missing genotypes within the sliding window before it is excluded from the ROH.
      
      --homozyg-het 1 \
      # --homozyg-het 1: allows at most 1 heterozygous SNP in the entire ROH for it to be considered valid.
      
      --homozyg-group \
      # --homozyg-group: groups contiguous homozygous segments, ensuring they are considered as part of the same ROH.
      
      --out eseal_roh
      # --out eseal_roh: specifies the base name for the output files, which will start with 'eseal_roh'.
Cool, so now we have a HOM file we can pop into RStudio and get some stats from. 

Number of ROH segments (NROH): 88 
Sum of ROH segment lengths (SROH): 21636591 bp
Fraction of genome in ROH (FROH): 0.89%

Here is the historgram of ROH distributions: 

![Mirounga PLINK ROH Distribution Plot](https://github.com/user-attachments/assets/ac2c7408-a1a5-4a6f-8e9c-4b958019d3ec)

Looks uglier than the BFCtools one :/ 

PLINK also allowed me to plot ROH length by chromosome: 

![Mirounga ROH Length by Chromosome Plot](https://github.com/user-attachments/assets/a78da517-652d-43a7-8961-d3f352bfd7d7)


OK... MUCH lower than the BCFtools output. Still expected, in a way? Will have to discuss with people smarter than me on what's actually correct. For now... Such is life. 
