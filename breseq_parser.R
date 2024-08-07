# Process breseq_outputs_clonalCSV2 to identify what mutations are present and/or relevant

library(dplyr)
library(stringr)

data <- read.csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/liquid_experiment_mutations/breseq_output.csv")

# the 3 known intergenic mutations in the ancestor strain are filtered out ahead of time

data_freq_only_noMC <- data %>%
  # filter(!is.na(frequency) & type != "UN") %>%
  # & !str_starts(gene_name, "PFLU_") & !str_starts(gene_name, "\\[PFLU_")
  filter(!is.na(frequency) & !str_starts(gene_name, "PFLU_0045/PFLU_0046") & !str_starts(gene_name, "PFLU_0872/PFLU_0873") & !str_starts(gene_name, "PFLU_3154/PFLU_3155") & type != "UN") %>%
  select(aa_ref_seq, aa_position, aa_new_seq, frequency, gene_name, gene_position, gene_product, locus_tag, mutation_category, type, breseq)

# write.csv(data_freq_only_noMC, file="/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/liquid_experiment_mutations/clonal_liquid_noMC_Hypothetical.csv", row.names = FALSE)

data_freq_only_MC <- data %>%
  #filter(!is.na(gene_name) & type != "UN") %>%
  # & !str_starts(gene_name, "PFLU_") & !str_starts(gene_name, "\\[PFLU_")
  filter(!is.na(gene_name) & !str_starts(gene_name, "PFLU_0045/PFLU_0046") & !str_starts(gene_name, "PFLU_0872/PFLU_0873") & !str_starts(gene_name, "PFLU_3154/PFLU_3155") & type != "UN") %>%
  select(aa_ref_seq, aa_position, aa_new_seq, frequency, gene_name, gene_position, gene_product, locus_tag, mutation_category, type, breseq)

write.csv(data_freq_only_MC, file="/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/liquid_experiment_mutations/clonal_liquid_MC_Hypothetical.csv", row.names = FALSE)
