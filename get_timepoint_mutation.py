import pandas as pd

# readin 
df = pd.read_csv('/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/clonal_dicty_mutations_D7.csv')
gene_names = df['gene_name'].unique()
replicates = range(1, 7)

all_combinations = pd.MultiIndex.from_product([gene_names, replicates], names=['gene_name', 'replicate']).to_frame(index=False)
all_combinations.head(10)

merged_df = all_combinations.merge(df, on=['gene_name', 'replicate'], how='left', indicator=True)
# print(merged_df)

merged_df['has_replicate'] = merged_df['_merge'] == 'both'
merged_df = merged_df.drop(columns=['_merge'])

aggregated_df = merged_df.groupby(['gene_name', 'replicate']).agg({'has_replicate': 'max'}).reset_index()

pivot_table = aggregated_df.pivot(index='gene_name', columns='replicate', values='has_replicate').fillna(False)

pivot_table = pivot_table.replace({True: 'YES', False: '.'})

pivot_table.to_csv("/Users/alanwang/Desktop/COOPERLAB_Summer2024/mutation_CSVs/clonal_dicty_mutations_D7_summary.csv")

