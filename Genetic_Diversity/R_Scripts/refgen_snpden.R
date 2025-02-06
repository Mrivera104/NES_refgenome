# Set the working directory to where the data files are located
setwd("C:/Users/Millie/Desktop/eseal_popgen") #Change the path to your own folder

# Load the required packages
library(tidyverse)
library(gdata)


# Read the SNP density data file
snpden <- read.table("SRR25478315_eseal_HD_PASS_DP5_hetsites_id.snpden.txt", header = TRUE)

# Define the order of the scaffolds to be used in the visualization
target <- c("SCAF_1", "SCAF_2", "SCAF_3", "SCAF_4", "SCAF_5", "SCAF_6", 
            "SCAF_7", "SCAF_8", "SCAF_9", "SCAF_10", "SCAF_11", "SCAF_12", 
            "SCAF_13", "SCAF_14", "SCAF_15", "SCAF_16", "SCAF_17")

# Define the order of the chromosomes to be used in the visualization
chr <- c('chr1','chr2','chr3','chr4','chr5','chr6','chr7','chr8','chr9','chr10',
         'chr11','chr12','chr13','chr14','chr15','chr16','chr17')

snpden.master <- snpden

# Reorder the chromosome column of the data frame according to the target order
snpden.master$CHROM <- factor(snpden.master$CHROM, levels = target)

# Subset data from chromosomes that are not "NA"
snpden.master <- subset(snpden.master, !is.na(snpden.master$CHROM))

snpden.master$groups <- cut(as.numeric(snpden.master$VARIANTS.KB), 
                            c(0.000, 0.005, 0.010, 0.015, 0.020, 0.025, 0.030, 0.035, 
                              0.040, 0.045, 0.050, 0.055, 0.060, 0.065, 0.070, 0.075, 
                              0.080, 0.085, 0.090, 0.095, 0.1),
                            include.lowest = TRUE, labels = c("0.000", "0.005-0.010", 
                                                              "0.010-0.015", "0.015-0.020", 
                                                              "0.020-0.025", "0.025-0.030", 
                                                              "0.030-0.035", "0.035-0.040", 
                                                              "0.040-0.045", "0.045-0.050", 
                                                              "0.050-0.055", "0.055-0.060", 
                                                              "0.060-0.065", "0.065-0.070", 
                                                              "0.070-0.075", "0.075-0.080", 
                                                              "0.080-0.085", "0.085-0.090", 
                                                              "0.090-0.095", "0.095-0.1"))

# Rename CHROM levels
levels(snpden.master$CHROM) <- c('chr1','chr2','chr3','chr4','chr5','chr6','chr7','chr8','chr9','chr10',
                                 'chr11','chr12','chr13','chr14','chr15','chr16','chr17')

snpden.master$BIN_START <- as.numeric(as.character(snpden.master$BIN_START))

snpden.master["Indiv"] <- "PB596"

names_vec <- c("PB596")

for (individual in unique(snpden.master$Indiv)) {
  # Subset the data for the current chromosome
  snpden.chr <- subset(snpden.master, snpden.master$Indiv == individual)
  
  # Define title
  title <- expression(paste(italic("Mirounga angustirostris")))
  
  # Create ggplot object 
  snpden_plot <- snpden.chr %>%
    mutate(Indiv = factor(Indiv, levels = c("PB596"))) %>%
    ggplot(aes(x = BIN_START, y = 1)) + 
    geom_tile(aes(fill = groups)) +
    facet_grid(CHROM ~ ., switch = 'y') +
    labs(x = 'Chromosome Length', 
         y = 'Scaffold Number', 
         title = expression(paste(italic("Mirounga angustirostris"))), 
         subtitle = paste0(individual, " heterozygous SNP densities")) + 
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank(),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          strip.text.y.left = element_text(angle = 0, size = 8),
          panel.spacing.y = unit(0.15, "lines"),
          plot.title = element_text(hjust = .5, size = 15),
          plot.subtitle = element_text(hjust = .5, size = 13, color = "darkgray")) +
    scale_fill_manual(values = c("#000081", "#0000f3", "#004dff", "#00b3ff", "#29ffce", 
                                 "#7bff7b", "#00FF21", "#ceff29", "#FFF300", "#ffc600", "#FFA800",
                                 "#ff6800", "#f30900", "brown", "#800000", "cyan", "purple", 
                                 "magenta", "yellow"),
                                  name = "Variants/kb",
                                  labels = c("0.000", "0.005-0.010", "0.010-0.015", 
                                              "0.015-0.020", "0.020-0.025", "0.025-0.030", "0.030-0.035", 
                                              "0.035-0.040", "0.040-0.045", "0.045-0.050", "0.050-0.055", 
                                              "0.055-0.060", "0.060-0.065", "0.065-0.070", "0.070-0.075", 
                                              "0.075-0.080", "0.080-0.085", "0.085-0.090", "0.090-0.095", "0.095-0.1")) +  
  scale_x_continuous(name = 'Chromosome length', labels = c('0Mb', "50Mb", '100Mb', 
                                                            "150Mb", '200Mb','250Mb'),
                     breaks = c(0, 50000000, 100000000, 150000000, 200000000, 250000000), 
                     expand = c(0, 0))

ggsave(filename = paste0('Mirounga_', individual, '.1Mb.snpden.png'), plot = snpden_plot, 
       device = 'png', dpi = 600, units = c('cm'), width = 28, height = 18, 
       path = "C:/Users/Millie/Desktop/", bg = "white")
}  

snpden_plot

