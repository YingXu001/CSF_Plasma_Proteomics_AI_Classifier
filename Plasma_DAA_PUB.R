rm(list = ls())

# Load necessary libraries
library(readr)      # For reading CSV files
library(dplyr)      # For data manipulation
library(broom)      # For tidying model outputs
library(ggplot2)    # For plotting
library(openxlsx)   # For writing Excel files
library(tidyr)


# Read in the data
combined_df <- read_csv("C:/Users/x.ying1/Downloads/merged_plasma_cross_sectional_call_rate_data_0130.xls")

pca <- read_csv("C:/Users/x.ying1/Downloads/merged_plasma_cross_sectional_call_rate_PCs_0201.csv")

dim(combined_df) # 4750 6648

combined_df$Sex <- gsub("^F$", "Female", combined_df$Sex)
combined_df$Sex <- gsub("^M$", "Male", combined_df$Sex)

# Demographic Table
combined_df %>%
  filter(selected_id == TRUE) %>%
  group_by(Status_at_draw_mapping) %>%
  summarise(
    N = n(),
    Female_count    = sum(Sex == "Female", na.rm = TRUE),
    Female_percent  = round(mean(Sex == "Female", na.rm = TRUE) * 100, 2),
    Age_mean        = round(mean(Age_at_draw, na.rm = TRUE), 1),
    Age_sd          = round(sd(Age_at_draw, na.rm = TRUE), 1)
  ) %>%
  mutate(
    `Female (%)`      = paste0(Female_count, " (", Female_percent, "%)"),
    `Age Mean (SD)`   = paste0(Age_mean, " (", Age_sd, ")")
  ) %>%
  select(
    Status_at_draw_mapping,
    N,
    `Female (%)`,
    `Age Mean (SD)`
  )


merged_df <- merge(combined_df, pca, by = c("UniquePhenoID"))
dim(merged_df)


ggplot(merged_df %>% filter(selected_id == TRUE), aes(x = PC1, y = PC2, color = Status_at_draw_mapping)) +
  geom_point() +
  labs(
    title = "Plasma PCA Plot",
    x = "PC1",
    y = "PC2"
  ) +
  theme_minimal() +
  theme(legend.position = "right")


filtered_df <- subset(merged_df, Status_at_draw_mapping %in% c("AD", "CO"))
dim(filtered_df)


sex_counts <- table(filtered_df$Sex)
print(sex_counts)


status_counts <- table(filtered_df$Status_at_draw_mapping)
print(status_counts)
# AD   CO  DLB  FTD   PD 
# 865 1282  122   44  687 

cohort_counts <- table(filtered_df$Project_x)
print(cohort_counts)
# Niagara   Pigeon Stanford 
# 1108     3014      628 


filtered_df$Age <- filtered_df$Age_at_draw
age_counts <- table(filtered_df$Age)
print(age_counts)


# Create a new column 'Status' where CO = 0, other statuses = 1
filtered_df$Status <- ifelse(filtered_df$Status_at_draw_mapping == "CO", 0, 1)
status_counts <- table(filtered_df$Status)
print(status_counts)


# Define protein columns that start with 'X'
proteins <- grep("^X", colnames(filtered_df), value = TRUE)
# print(proteins)

# Create a data frame to store results
significance_results <- data.frame(
  Protein = character(),
  EffectSize = numeric(),
  SE = numeric(),
  Status_at_draw_PValue = numeric(),
  stringsAsFactors = FALSE
)

# Run regression for each protein and extract effect size, SE, and p-value
for (protein in proteins) {
  formula <- as.formula(paste(protein, "~ Status + Age + Sex + PC1 + PC2"))
  # formula <- as.formula(paste(protein, "~ Status + Age + Sex + Batch + PC1 + PC2"))
  # formula <- as.formula(paste(protein, "~ Status + Age + Sex"))
  model <- lm(formula, data = filtered_df)
  coefficients_table <- summary(model)$coefficients
  
  # Check for the correct coefficient name for Status
  coefficient_names <- grep("Status", rownames(coefficients_table), value = TRUE)
  
  for (coeff_name in coefficient_names) {
    effect_size <- coefficients_table[coeff_name, "Estimate"]  # Extract effect size
    se <- coefficients_table[coeff_name, "Std. Error"]  # Extract standard error
    p_value <- coefficients_table[coeff_name, "Pr(>|t|)"]  # Extract p-value
    significance_results <- rbind(significance_results, data.frame(
      Protein = protein, 
      EffectSize = effect_size, 
      SE = se,
      PValue = p_value
    ))
  }
}

# Perform FDR correction using Benjamini-Hochberg method
significance_results$FDR_BH_PValue <- p.adjust(significance_results$PValue, method = "BH")

# Perform Bonferroni correction
significance_results$Bonferroni_PValue <- p.adjust(significance_results$PValue, method = "bonferroni")

# Display the first few results without altering the order
head(significance_results)

# Save the results to an Excel file without altering the order
write.xlsx(significance_results, "C:/Users/x.ying1/Downloads/Plasma_DAA_CO_AD_0312.xlsx", rowNames = FALSE)
