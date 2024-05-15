
# Set working directory 
setwd("C:/Users/Millie/Desktop/eseal_popgen")

# Load the required packages 
library(ggplot2)
library(viridis)

# Create a dataframe with the repet type data
repeat_table <- read.csv("repeat_type.csv", header=TRUE)

# Convert 'Type' column to factor and reorder levels based on Percentage
repeat_table$Type <- factor(repeat_table$Type, levels = repeat_table$Type[order(-repeat_table$Percentage)])

repeat_plot <- ggplot(data = repeat_table, aes(x = "", y = Percentage, fill = Type)) + 
  geom_col(width = .25) + 
  scale_fill_viridis_d(option = "H") + 
  coord_flip() +
  theme(panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "white"), 
        panel.background = element_rect(fill='white', 
                                        colour='white')) 

# Save plot out to desktop 
ggsave(filename = paste0('Repeat_Element_Percentage.png'), plot = repeat_plot, 
       device = 'png', dpi = 600, units = c('cm'), width = 28, height = 18, 
       path = "C:/Users/Millie/Desktop/", bg = "white")

# Visualize plot 
repeat_plot

