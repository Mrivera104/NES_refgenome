# PSMC Analysis on M. agunstirostris Reference Genome
Documentation began on  02/14/2024 (Valentine's Day!!!!!!!). I will be running a PSMC model analysis on the northern elephant seal (Mirounga angustirostris) CCGP reference genome. This will (hopefully) allow me to look at how demography/effective population size has changed throughout time. 

UPDATE 08/15/2024: WE'RE BACK! I gave up on this for a long, long time because I just couldn't figure out how to properly do things (like, using the short-read Omni-C data, filtering, ect) but now we're back and better than ever. 

I decided to do bootstrapping, seeing as I'm working with a single sample. We're going to go through this step by step: 

Step 1: Convert FASTQ to PSMC input format

    fq2psmcfa -q20 SRR25478315_bridgetrim_sorted_only_mapped.fq.gz > SRR25478315_bridgetrim_sorted_only_mapped.psmcfa
Step 2: Run the initial PSMC command
    
    psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o SRR25478315_bridgetrim.psmc SRR25478315_bridgetrim_sorted_only_mapped.psmcfa
Step 3: Split the PSMCFA file for bootstrapping

    splitfa SRR25478315_bridgetrim_sorted_only_mapped.psmcfa > SRR25478315_bridgetrim_split_psmcfa_file.split.psmcfa
Step 4: Perform 100 bootstrap replicates

    seq 100 | xargs -P 4 -I {} psmc -N25 -t15 -r5 -b -p "4+25*2+4+6" -o SRR25478315_bridgetrim_round-{}.psmc SRR25478315_bridgetrim_split_psmcfa_file.split.psmcfa
Step 5: Combine the original and bootstrap PSMC files

    cat SRR25478315_bridgetrim.psmc SRR25478315_bridgetrim_round-*.psmc > SRR25478315_bridgetrim_combined.psmc
Step 6: Generate plots, including a PDF, with psmc_plot.pl

    psmc_plot.pl -g 10 -u 1e-8 -X 1000000 -Y 16 SRR25478315_bridgetrim_combined SRR25478315_bridgetrim_combined.psmc

