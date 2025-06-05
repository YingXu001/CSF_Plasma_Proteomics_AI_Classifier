rm(list = ls())

# Load necessary libraries
library(readr)      # For reading CSV files
library(dplyr)      # For data manipulation
library(broom)      # For tidying model outputs
library(ggplot2)    # For plotting
library(openxlsx)   # For writing Excel files
library(stats)      # For PCA calculation

# Read in the data
combined_df <- read_csv("C:/Users/x.ying1/Downloads/merged_csf_cross_sectional_call_rate_data_0130.xls")

dim(combined_df) # 4677 3667

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


sum(is.na(combined_df$Sex))
sex_counts <- table(combined_df$Sex)
print(sex_counts)
# Female   Male 
# 2383     2294 

sum(is.na(combined_df$Age_at_draw))

status_counts <- table(combined_df$Status_at_draw_mapping)
print(status_counts)
# AD  CO DLB FTD  PD 
# 744 665  18   9 738
# AD  CO DLB FTD  PD 
# 744 665  37  46 738 

cohort_counts <- table(combined_df$Project_x)
print(cohort_counts)
# Garfield    Longs     PPMI Stanford 
# 450          2888     1075      264 



# Function to fill missing values (for columns starting with 'X')
fill_missing_values <- function(df) {
  # Set the random seed for reproducibility
  set.seed(2)
  
  # Identify columns that start with 'X'
  x_columns <- grep("^X", colnames(df), value = TRUE)
  
  # Perform bootstrapping to fill missing values in each column
  for (col_name in x_columns) {
    # Get the index of missing values in the current column
    na_index <- is.na(df[[col_name]])
    
    # If there are missing values, fill them using bootstrapping
    if (sum(na_index) > 0) {
      df[na_index, col_name] <- sample(
        df[[col_name]][!na_index], 
        sum(na_index), 
        replace = TRUE
      )
    }
  }
  return(df)
}

# Apply the function to fill missing values
combined_df <- fill_missing_values(combined_df)


perform_pca_zscored <- function(df) {
  # Identify columns that start with 'X'
  x_columns <- grep("^X", colnames(df), value = TRUE)
  
  # Select the columns that start with 'X' for PCA (assuming already Z-scored)
  pca_data <- df[, x_columns]
  
  # Perform PCA directly (without scaling again)
  pca_result <- prcomp(pca_data, center = FALSE, scale. = FALSE)
  
  # Return the PCA results
  return(pca_result)
}


# Perform PCA analysis on already Z-scored matrix
pca_result <- perform_pca_zscored(combined_df)

# Extract the first five principal components (PC1 to PC5)
pc_data <- as.data.frame(pca_result$x[, 1:5])

# Ensure UniquePhenoID is included in the final dataset
pc_data$UniquePhenoID <- combined_df$UniquePhenoID

# Save the PC1 to PC5 with UniquePhenoID as a CSV file
write_csv(pc_data, "C:/Users/x.ying1/Downloads/merged_csf_cross_sectional_call_rate_PCs_0312.csv")

