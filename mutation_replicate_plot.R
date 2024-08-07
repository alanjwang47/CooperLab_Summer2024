# Create plots of mutations from different timepoints within the same replicate. 

# Input: CSV file with columns: replicate, time, mutation, frequency

library(ggplot2)
library(grid)

d = read.csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/dicty_experiment_mutations/mutation_nonsyn_plot_replicate_goodquality.csv")

fig<-c("clonal_mutation_nonsyn_replicate_plot_goodquality.pdf")
folder=c("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/")
fig.file<-paste(folder,fig,sep="")
pdf(fig.file,onefile=T,width=6,height=6)

# INCREASE AXIS FONT SIZE (like 0.1, Day 0, etc)
ggplot(data=d, aes(x=Sample, y=Frequency, color=Mutation)) +
  labs(color="Nonsynonymous Mutations") +
  geom_point(size=4) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 13),
        axis.text.y = element_text(size = 13),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.text = element_text(size=10),
        legend.title = element_text(size=12))
  
  
dev.off()
