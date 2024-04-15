# PSMC Analysis on M. agunstirostris Reference Genome
Documentation began on  02/14/2024 (Valentine's Day!!!!!!!). I will be running a PSMC model analysis on the northern elephant seal (Mirounga angustirostris) CCGP reference genome. This will (hopefully) allow me to look at how demography/effective population size has changed throughout time. 

# Notes
I will be using the NES hap1 fasta to map all of my files to. 

Originally, I thought about mapping the hap2 fasta to hap1 to use for my PSMC analyses. The first couple times I've tried it hasn't worked, but I think I may have found a work around it... 

I am currently making a repeat-masked version of my hap1 fasta file - I will be using this version to do three analyses: 1.) map my highest-coverage resequenced individual (QC'd using fastp) to the repeat-masked fasta 2.) map the hap2 fasta to the repeat-masked hap1 fasta 3.) map the hap2 Omni-C data to the hap1 repeat-masked fasta. 

I really hope one of these will work. I am crying ...

# create conda environment 
>conda create --name eseal python=3.4
>activate eseal

check environments 
>conda env list
>conda info

# installing packages 
> conda instal bioconda::samtools
> 
> conda install bioconda::bcftools
> 
> conda install bioconda::gatk4
> 
> conda install bioconda::picard

# Create an index for our fasta file 
> samtools faidx /scratch1/migriver_CCGP/PSMC/refs/20230202.mMirAng1.NCBI.hap1.fasta
output is: 20230202.mMirAng1.NCBI.hap1.fasta.fai

# Method 1
1.) map my highest-coverage resequenced individual (QC'd using fastp) to the repeat-masked fasta

fastp code used: 
#!/bin/bash

# Fastp script for my fastq file quality control 
# going to map the output to the repeat-masked fasta

# Directory containing the input FASTQ files
input_dir="/scratch1/migriver_CCGP/fastp"
#input_dir="/projects/dittrichia/test"

# Directory to store the output FASTP files
output_dir="/scratch1/migriver_CCGP/fastp"

# Fastp settings

fastp_options="--trim_poly_g --trim_poly_x -t 1 -T 1 --n_base_limit 5 --detect_adapter_for_pe --qualified_quality_phred 15 --unqualified_percent_limit 40 --cut_mean_quality 30 --average_qual 25 --low_complexity_filter --thread 8 --dont_overwrite --length_required 25 --correction --dedup --trim_poly_g -5 -3 -r -W 5"

> # Iterate over the input R1 files in the directory
> for input_file_r1 in "${input_dir}"/*_R1_*.fastq.gz; do
>    # Extract the base name by removing "_R1_" and the extension
 >   base_name=$(basename "${input_file_r1}" | sed 's/_R1_.*//')

  >  # Construct the paths for the input and output files
   > input_file_r2="${input_dir}/${base_name}_R2_001.fastq.gz"
    output_file1="${output_dir}/${base_name}.fastp.R1.fastq.gz"
    output_file2="${output_dir}/${base_name}.fastp.R2.fastq.gz"
    html_report="${output_dir}/${base_name}.fastp.html"
    json_report="${output_dir}/${base_name}.fastp.json"

  > # Run fastp on the input files
    > fastp --in1 "${input_file_r1}" --out1 "${output_file1}" \
          --in2 "${input_file_r2}" --out2 "${output_file2}" \
          --html "${html_report}" \
          --json "${json_report}" ${fastp_options}

   > echo "Processed: ${base_name}"
done


# Method 2


