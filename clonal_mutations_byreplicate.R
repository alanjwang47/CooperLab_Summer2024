# Process cleaned breseq CSV files by replicate so it is easier to see if mutations are longitudinal

library(dplyr)
library(stringr)

# Doing this for datasets NOT including "unassigned missing coverage evidence" calls, i.e., they don't have a frequency
data <- read.csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/liquid_experiment_mutations/clonal_liquid_noMC_Hypothetical.csv")

data_rep_only <- data %>%
  filter(str_starts(breseq, "C6D1") | str_starts(breseq, "C6D2") | str_starts(breseq, "C6D3") | str_starts(breseq, "C6D4") | str_starts(breseq, "C6D5") | str_starts(breseq, "C6D7"))

write.csv(data_rep_only, file="/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/liquid_experiment_mutations/clonal_liquid_C6.csv", row.names = FALSE)