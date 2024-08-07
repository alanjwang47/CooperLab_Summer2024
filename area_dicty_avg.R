# GOAL = make figure based on clonal Dicty x Pflu experiment averaged across all replicates

library(ggplot2)
library(dplyr)

# read in the data that only contains clonal treatment
g = read.csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/AW_Dicty_Exp1.csv")
head(g)

# Create a function that calculates 95% confidence intervals for the given data vector using a t-distribution
conf_int95 <- function(data) {
  n <- length(data)
  error <- qt(0.975, df=n-1) * sd(data)/sqrt(n)
  return(error)}

# make zero time point the same for all treatments
h = subset(g, subset = Day ==0) # subset zero time point
g = subset(g, subset = Day !=0) # remove subset from original dataframe

print(h)
print(g)

# # create a dataframe containing the info for time zero
zero1 <- h %>%
  dplyr::group_by(Day) %>%
  dplyr::summarise(Average=mean(Area),CI95=conf_int95(Area))

print(zero1)

# ready original dataset
stats <- g %>%
  dplyr::group_by(Day) %>%
  dplyr::summarise(Average=mean(Area),CI95=conf_int95(Area))

head(stats)

# combine zero time point dataframe with remaining time points
final = rbind(zero1, stats)
print(final)

# change names of columns for plotting
names(final)= c("Days", "Area", "CI95")

# # plotting

folder = c("/Users/alanwang/Desktop/") # tell it where you want it to put the figure

fig2<-c("fig_dicty_averageCLONAL.pdf") # name your figure
fig2.file<-paste(folder,fig2,sep="")
pdf(fig2.file,onefile=T,width=5,height=4)

p <- ggplot(data=final, aes(x=Days, y=Area)) +
  geom_line(size=1) +     #connects the points, tell it what size you want the line
  geom_point(size=1.5) +  #tell it what size you want the points
  geom_errorbar(aes(x=Days, ymin=Area-(1/2*CI95), ymax=Area+(1/2*CI95), width=0.25)) +
  theme_bw()

p + scale_x_continuous(limits=c(0,10), breaks=seq(0, 10, by=2)) + scale_y_continuous(limits=c(0,60), breaks=seq(0, 50, by=10)) +
  ylab(expression(Area ~ (cm^2)))

dev.off()



