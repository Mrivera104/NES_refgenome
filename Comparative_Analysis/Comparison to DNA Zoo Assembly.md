# Comparison to DNA Zoo assembly 
Today, for a final little addition to the already ginormagantuan reference genome paper, I am going to align our CCGP reference genome assembly to the last published northern elephant seal assemly published by the DNA Zoo. This will be done using minimap2 to create a PAF file, then that will get uploaded to the D-Genies website (https://dgenies.toulouse.inra.fr) to produce a synteny analysis and figure. 

First, I downloaded the DNA Zoo assembly from NCBI (GCF_021288785.2_ASM2128878v3) and uploaded it to kelpser. Next, I ran minimap2 to align our CCGP assembly (query) to the DNA Zoo assemly (target):

    minimap2 -x asm5 -t 80 /scratch1/migriver_CCGP/ncbi_dataset/ASM2128878v3/GCF_021288785.2/GCF_021288785.2_ASM2128878v3_genomic.fna 20230202.mMirAng1.NCBI.hap1.fasta > map_ccgp_to_dnazoo.paf
