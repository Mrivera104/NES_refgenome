# PSMC Analysis on M. agunstirostris Reference Genome
Documentation began on  02/14/2024 (Valentine's Day!!!!!!!). I will be running a PSMC model analysis on the northern elephant seal (Mirounga angustirostris) CCGP reference genome. This will (hopefully) allow me to look at how demography/effective population size has changed throughout time. 

UPDATE 08/15/2024: WE'RE BACK! I gave up on this for a long, long time because I just couldn't figure out how to properly do things (like, using the short-read Omni-C data, filtering, ect) but now we're back and better than ever. 

I decided to do bootstrapping, seeing as I'm working with a single sample. We're going to go through this step by step: 

Step 1: Create a whole-genome diploid consensus sequence where the i-th character in the output sequence indicates whether there is at least one heterozygote in the bin (https://github.com/lh3/psmc):

    bcftools mpileup -Ou -C50 -f /scratch1/migriver_CCGP/trim_omnic/20230202.mMirAng1.NCBI.hap1.fasta /scratch1/migriver_CCGP/trim_omnic/SRR25478315_bridgetrim_sorted_only_mapped.bam | bcftools call -c | vcfutils.pl vcf2fq -d 8 -D 32 | gzip > SRR25478315_bridgetrim_sorted_only_mapped.fq.gz
Step 2: Convert FASTQ to PSMC input format

    fq2psmcfa -q20 SRR25478315_bridgetrim_sorted_only_mapped.fq.gz > SRR25478315_bridgetrim_sorted_only_mapped.psmcfa
Step 3: Run the initial PSMC command
    
    psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o SRR25478315_bridgetrim.psmc SRR25478315_bridgetrim_sorted_only_mapped.psmcfa
Step 4: Split the PSMCFA file for bootstrapping

    splitfa SRR25478315_bridgetrim_sorted_only_mapped.psmcfa > SRR25478315_bridgetrim_split_psmcfa_file.split.psmcfa
Step 5: Perform 100 bootstrap replicates

    seq 100 | xargs -P 4 -I {} psmc -N25 -t15 -r5 -b -p "4+25*2+4+6" -o SRR25478315_bridgetrim_round-{}.psmc SRR25478315_bridgetrim_split_psmcfa_file.split.psmcfa
Step 6: Combine the original and bootstrap PSMC files

    cat SRR25478315_bridgetrim.psmc SRR25478315_bridgetrim_round-*.psmc > SRR25478315_bridgetrim_combined.psmc
Step 7: Generate plots, including a PDF, with psmc_plot.pl
mutation rate of 1.8x10^8 

    psmc_plot.pl -g 10 -u 1e-8 -X 1000000 -Y 16 SRR25478315_bridgetrim_combined SRR25478315_bridgetrim_combined.psmc

Mutation rate of 6.7x10^-9 (https://www.nature.com/articles/s41559-020-1215-5) 

    psmc_plot.pl -g 9 -u 6.7e-9 -X 1000000 -Y 16 SRR25478315_bridgetrim_combined_8gen SRR25478315_bridgetrim_combined.psmc

And this was the output! 

![Screenshot 2024-08-26 144111](https://github.com/user-attachments/assets/80b450bb-d3ee-410d-91d3-8d8c8e6ca9bc)

![Screenshot 2024-08-26 144219](https://github.com/user-attachments/assets/1a4ac5cd-9a1d-4a9a-9e07-2fb5069d51bc)


Yay, makes sense to me! I trust this more than Hoelzel et al. 2024 tbh. 

