#!/bin/bash

#Set variables

input_bam_file="/scratch1/migriver_CCGP/ncbi_dataset/omnic_mapfiles/SRR25478315_eseal_sorted.bam"
ancestral_fasta_file="/scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta"
reference_fasta_file="/scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta"
output_directory="/scratch1/migriver_CCGP/avg_het"
SAMPLE="SRR25478315"

# Run ANGSD command
angsd -P 10 -i ${input_bam_file} -anc ${ancestral_fasta_file} -dosaf 1 -gl 1 -C 50 -minQ 20 -minmapq 30 -fold 1 -out ${output_directory}/$SAMPLE -ref ${reference_fasta_file} -r

# Run realSFS command
realSFS -nsites 200000 ${output_directory}/$SAMPLE.saf.idx > ${output_directory}/$SAMPLE.est.ml

done
