# Calculate repeat content and type for the northern elephant seal reference genome
I worked with Rachel to download RepeatModeler/RepetMasker and use that on the n. elephant seal genome. At first, I used this to mask repeats from the haplotype 1 reference genome fasta file. I wanted to use this repeat-masked file to then do all my subsequent analyses, but for some reason the mapping takes way longer. I decided to scrap the idea of creating bam files from the repeat-masked reference genome, but at least I can report on repeat content and type. 

This is the code I used for repeat-masking: 

    RepeatMasker -species mammals /scratch1/migriver_CCGP/ncbi_dataset/20230202.mMirAng1.NCBI.hap1.fasta 

Here at the results for M. angustirostris from using RepeatMasker: 

    ==================================================
    file name: 20230202.mMirAng1.NCBI.hap1.fasta
    sequences:           498
    total length: 2430321998 bp  (2430312198 bp excl N/X-runs)
    GC level:         41.84 %
    bases masked:  845352690 bp ( 34.78 %)
    ==================================================
                   number of      length   percentage
                   elements*    occupied  of sequence
    --------------------------------------------------
    SINEs:            493955     73461432 bp    3.02 %
          Alu/B1          10          617 bp    0.00 %
          MIRs        486039     72498231 bp    2.98 %
    
    LINEs:            875423    495009942 bp   20.37 %
          LINE1       481842    389573753 bp   16.03 %
          LINE2       333612     91943305 bp    3.78 %
          L3/CR1       45005      9790405 bp    0.40 %
          RTE          13619      3489053 bp    0.14 %
    
    LTR elements:     326138    118406834 bp    4.87 %
          ERVL         90947     40916885 bp    1.68 %
          ERVL-MaLRs  150543     53054229 bp    2.18 %
          ERV_classI   37696     15416198 bp    0.63 %
          ERV_classII  21091      2154206 bp    0.09 %
    
    DNA elements:     367814     74502609 bp    3.07 %
          hAT-Charlie 203235     38534487 bp    1.59 %
          TcMar-Tigger 68300     17505253 bp    0.72 %
    
    Unclassified:       7599      1211075 bp    0.05 %
    
    Total interspersed repeats: 762591892 bp   31.38 %
    
    
    Small RNA:        114252      8383019 bp    0.34 %
    
    Satellites:         4372       503553 bp    0.02 %
    Simple repeats:   1149138     49751923 bp    2.05 %
    Low complexity:   478227     23925613 bp    0.98 %
    ==================================================
    
    * most repeats fragmented by insertions or deletions
      have been counted as one element
                                                          
    
    The query species was assumed to be mammals       
    RepeatMasker version 4.1.5 , default mode
                                            
    run with rmblastn version 2.14.1+
    FamDB: CONS-Dfam_3.7


I made a plot in R that is located in the Repeat_Content folder. This is what the figure looks like: 

![Repeat_Element_Percentage](https://github.com/Mrivera104/eseal_CCGP/assets/97764650/ab5e7ef5-0673-4181-b95f-fe32251c7594)

Next steps: I want the percentages to show up on this figure but I have no clue how to make that happen without them being super compressed or not legable. I will figure it out :P

# Comparison of TE Content to Related Marine Mammal Species 
I decided to do a TE content comparison to related species. WHOOPS! I decided to compare the NES to the following species: Mirounga Leonina	// Monachus schauinlandi // Phoca vitulina // Halichoerus grypus // Zalophus californianus // Enhydra lutris kenyoni // Ursus maritimus


