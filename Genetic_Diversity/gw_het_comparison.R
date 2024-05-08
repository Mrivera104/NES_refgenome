# Let's make a figure plotting marine mammal nucleotide diversity across taxa for a nice little comparison! 

setwd("C:/Users/Millie/Desktop/eseal_popgen") # Set working directory 

# Initialize  required packages 
library(viridis)
library(ggplot2)
library(dplyr)
library(rphylopic)

dataframe<-read.csv("nuc_diversity_marinemammals.csv", header = T) # Read in CSV 
dataframe <- dataframe[order(dataframe$Heterozygosity,decreasing=TRUE),] # Order data frame in order of decreasing heterozygosity 
dataframe <- dataframe[!is.na(dataframe$Heterozygosity), ]

status_colors <- c("LC" = "steelblue1", "VU" = "goldenrod1", "EN" = "sienna1", "CR" = "tomato2") # Set IUCN status colors

uuid <- get_uuid(name = "Mirounga leonina", n = 1) # Load in phylopic object and quantity
img <- get_phylopic(uuid = uuid) # Load in phylopic image

# Plotting code
nuc_plot <- ggplot(dataframe, aes(reorder(Species, Heterozygosity), Heterozygosity)) +
  geom_col(aes(fill = Status), width = 0.7) +  
  coord_flip() + 
  expand_limits(x = 0.000) + 
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.003)) + 
  xlab("Species (common name)") + ylab("Nucleotide Diversity (π)") +
  labs(fill = "IUCN Status") +
  scale_fill_manual(values = status_colors) + 
  add_phylopic(x = 12, y = 0.0019, ysize = 10, img = img) + 
  geom_segment(aes(x = 8.5, y = 0.0015, xend = 5, yend = 0.00025), 
    size = 1,
    arrow = arrow(length = unit(0.5, "cm"))) +
  theme_bw()

nuc_plot # Visualize plot 
