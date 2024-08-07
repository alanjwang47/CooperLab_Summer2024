# Create plots of mutations from different replicates within the same day. 

# Input: CSV file with columns: replicate, time, mutation, frequency

library(ggplot2)

d = read.csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/dicty_experiment_mutations/mutation_plot_day.csv")

fig<-c("dicty_mutation_day_plot.pdf")
folder=c("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/")
fig.file<-paste(folder,fig,sep="")
pdf(fig.file,onefile=T,width=4.74,height=4.65)

ggplot(data=d, aes(x=Replicate, y=Frequency, color=Mutation)) +
  geom_point(size=2) + #ylab("Log(Final-Initial Quantity)") +
  facet_wrap(~Day) + labs(title = "Mutation frequencies across days") +
  theme(panel.grid.minor = element_blank(),panel.grid.major = element_blank())

dev.off()
