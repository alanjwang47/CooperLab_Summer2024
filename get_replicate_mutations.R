# Create a table of what mutations are similar across time points within the same replicate

# Input file 1: a CSV file that has all the mutations of each timepoint within a single replicate

library(dplyr)

data <- read.csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/liquid_experiment_mutations/clonal_liquid_C6.csv")

data_day0 <- read.csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/liquid_experiment_mutations/clonal_dicty_C0.csv")

# Create indicator variables for presence on each day
data_day0 <- data_day0 %>%
  mutate(day_0 = if_else(breseq == "C0", "Yes", NA_character_),
         day_1 = NA_character_,
         day_2 = NA_character_,
         day_3 = NA_character_,
         day_4 = NA_character_,
         day_5 = NA_character_,
         day_7 = NA_character_)

data <- data %>%
  mutate(day_0 = if_else(breseq == "C0", "Yes", NA_character_),
         day_1 = if_else(breseq == "C6D1", "Yes", NA_character_),
         day_2 = if_else(breseq == "C6D2", "Yes", NA_character_),
         day_3 = if_else(breseq == "C6D3", "Yes", NA_character_),
         day_4 = if_else(breseq == "C6D4", "Yes", NA_character_),
         day_5 = if_else(breseq == "C6D5", "Yes", NA_character_),
         day_7 = if_else(breseq == "C6D7", "Yes", NA_character_))

combined_data <- rbind(data, data_day0)

# Group by gene name and summarize the presence on each day
gene_presence <- combined_data %>%
  group_by(gene_name) %>%
  summarise(
    day_0 = first(na.omit(day_0)),
    day_1 = first(na.omit(day_1)),
    day_2 = first(na.omit(day_2)),
    day_3 = first(na.omit(day_3)),
    day_4 = first(na.omit(day_4)),
    day_5 = first(na.omit(day_5)),
    day_7 = first(na.omit(day_7))
  ) %>%
  ungroup()

# Select relevant columns for the final output
final_table <- gene_presence %>%
  select(gene_name, day_0, day_1, day_2, day_3, day_4, day_5, day_7)


write.csv(final_table, file="/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/liquid_experiment_mutations/clonal_liquid_C6_summary.csv", row.names = FALSE)
