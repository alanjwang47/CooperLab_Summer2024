# GOAL = make figure based on clonal Dicty x Pflu experiment for each replicate

library(ggplot2)
library(dplyr)

# read in data that only contains clonal treatment
data = read.csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/AW_barcode dicty.csv")
head(data)

# remove unneeded columns
data <- select(data, -Sample, -Mean, -Min, -Max)

# arrange rows by replicate number
rep_data <- data %>%
  arrange(Replicate) %>%
  mutate(Replicate = factor(Replicate))

# where you want to put the figure
folder = c("/Users/alanwang/Desktop/") 

# figure name
fig2<-c("fig_dicty_reps_BARCODE.pdf") 
fig2.file<-paste(folder,fig2,sep="")
pdf(fig2.file,onefile=T,width=5,height=4)

p <- ggplot(data=rep_data, aes(x=Day, y=Area, group=Replicate, color=Replicate)) +
  geom_line(size=1) +     
  geom_point(size=1.5) +
  theme_bw()

p + scale_x_continuous(limits=c(0,8.5)) + scale_y_continuous(limits=c(0,53), breaks=seq(0, 50, by=10)) +
  ylab(expression(Area ~ (cm^2)))

dev.off()


