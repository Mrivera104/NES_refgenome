# eseal_CCGP
analyses for the elephant seal CCGP ref genome paper 

> on 06/15/2023, I took time with Rachel to run Minimap2 and look at assembly statistics and create delta plots to visualize alignment statistics. 
> 
> CCGP N. elephant seal sequence used: 20230202.mMirAng1.NCBI.hap1.fasta
> 
> S. elephant seal query sequence used: GCF_011800145.1_KU_Mleo_1.0_genomic.fna (Mirounga leonina reference on NCBI published by the Earth Biogenome project)

> stats for 20230202.mMirAng1.NCBI.hap1.fasta (using assembly-stats)
sum = 2430321998, n = 498, ave = 4880164.65, largest = 215935216
N50 = 154172358, n = 7
N60 = 144560927, n = 9
N70 = 138646194, n = 10
N80 = 109230848, n = 12
N90 = 93938456, n = 15
N100 = 5350, n = 498
N_count = 9800
Gaps = 98

> stats for GCF_011800145.1_KU_Mleo_1.0_genomic.fna (using assembly-stats)
sum = 2417320305, n = 1115, ave = 2168000.27, largest = 111625095
N50 = 54232831, n = 16
N60 = 38232912, n = 21
N70 = 30109608, n = 28
N80 = 23083835, n = 37
N90 = 11830400, n = 51
N100 = 10003, n = 1115
N_count = 15584573
Gaps = 22850

> MINIMAP2 SCRIPT ASM10: 
> minimap2 -x asm10 --sam-hit-only 20230202.mMirAng1.NCBI.hap1.fasta.gz ncbi-genomes-2023-06-15  GCF_011800145.1_KU_Mleo_1.0_genomic.fna.gz > map_mleo_to_mang.paf
RESULTS: [M::mm_idx_gen::46.180*1.58] collected minimizers
[M::mm_idx_gen::53.060*1.76] sorted minimizers
[M::main::53.060*1.76] loaded/built the index for 498 target sequence(s)
[M::mm_mapopt_update::56.328*1.72] mid_occ = 103
[M::mm_idx_stat] kmer size: 19; skip: 19; is_hpc: 0; #seq: 498
[M::mm_idx_stat::58.375*1.69] distinct minimizers: 189911280 (94.54% are singletons); average occurrences: 1.283; average spacing: 9.977; total length: 2430321998
[M::worker_pipeline::131.773*2.16] mapped 379 sequences
[M::worker_pipeline::193.176*2.35] mapped 102 sequences
[M::worker_pipeline::249.530*2.46] mapped 46 sequences
[M::worker_pipeline::322.843*2.39] mapped 343 sequences
[M::worker_pipeline::362.144*2.43] mapped 245 sequences
[M::main] Version: 2.26-r1175
[M::main] CMD: minimap2 -x asm10 --sam-hit-only 20230202.mMirAng1.NCBI.hap1.fasta.gz ncbi-genomes-2023-06-15 GCF_011800145.1_KU_Mleo_1.0_genomic.fna.gz
[M::main] Real time: 362.353 sec; CPU: 879.507 sec; Peak RSS: 9.918 GB

> MINIMAP2 SCRIPT ASM5: 
> minimap2 -x asm5 --cs --sam-hit-only 20230202.mMirAng1.NCBI.hap1.fasta.gz ncbi-genomes-2023-06-15  GCF_011800145.1_KU_Mleo_1.0_genomic.fna.gz > map_mleo_to_mang_asm5.paf

> D-genies link: https://dgenies.toulouse.inra.fr/result/mirounga1
>
> Summary of Identity: 
>![summary_GCF_011800145 1_KU_Mleo_1 0_genomic_to_20230202 mMirAng1 NCBI hap1](https://github.com/Mrivera104/eseal_CCGP/assets/97764650/40bc4026-bd87-439b-9641-0d251e0fa12d)
>
> Delta plot: 
> ![map_GCF_011800145 1_KU_Mleo_1 0_genomic_to_20230202 mMirAng1 NCBI hap1](https://github.com/Mrivera104/eseal_CCGP/assets/97764650/63cad978-2068-40a2-aea4-9c08a192a341)


> Assemblytics link: http://assemblytics.com/analysis.php?code=jIFPAW6kAGJlHlIjn3Vy
> 
> ![Mirounga Assemblytics Nchart](https://github.com/Mrivera104/eseal_CCGP/assets/97764650/0f749f62-dbdc-442c-860a-fbe317c51e22)
> ![Mirounga Assemblytics size_distributions all_variants 50-500](https://github.com/Mrivera104/eseal_CCGP/assets/97764650/3b6485e5-b8f5-4236-aed3-680477f07bfa)
> ![Mirounga Assemblytics size_distributions all_variants 500-50000](https://github.com/Mrivera104/eseal_CCGP/assets/97764650/2e2b887b-103d-4f70-b152-ed9d075e356d)
> ![Mirounga Assemblytics size_distributions all_variants log_all_sizes](https://github.com/Mrivera104/eseal_CCGP/assets/97764650/6a467c8a-3c94-4258-93ca-ca8a5d885a1b)

> Reference: CCGP N. elephant seal
Number of sequences: 93
Total sequence length: 2.39 Gbp
Mean: 25.74 Mbp
Min: 14.15 Kbp
Max: 215.94 Mbp
N50: 154.17 Mbp

> Query: Earth Biogenome S. elephant seal
Number of sequences: 1,064
Total sequence length: 2.42 Gbp
Mean: 2.27 Mbp
Min: 10.0 Kbp
Max: 111.63 Mbp
N50: 54.23 Mbp
