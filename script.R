### **File 2: `script.R`**
*Click **Add file** $\rightarrow$ **Create new file**, name it `script.R`, and paste this R code:*

```R
# ==============================================================================
# Week 1 Task: Data Cleaning and Preliminary Analysis in R
# ==============================================================================

# Step 1: Load Required Libraries
library(tidyverse)
library(caret)
library(corrplot)

# Step 2: Data Ingestion & Structural Inspection
raw_data <- read.csv('ecommerce_customer_data.csv', stringsAsFactors = FALSE)

cat("--- INITIAL SCHEMA & STRUCTURE ---\n")
str(raw_data)

cat("\n--- RAW DATA SUMMARY STATISTICS ---\n")
summary(raw_data)

# Step 3: Missing Value Imputation
# Helper function to compute statistical mode
get_mode <- function(v) {
  uniqv <- unique(na.omit(v))
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

clean_data <- raw_data %>%
  # Impute categorical fields with Mode
  mutate(Membership_Tier = if_else(is.na(Membership_Tier) | Membership_Tier == '',
                                   get_mode(Membership_Tier), Membership_Tier)) %>%
  # Impute continuous fields with Grouped Median
  group_by(Membership_Tier) %>%
  mutate(Annual_Income = if_else(is.na(Annual_Income),
                                 median(Annual_Income, na.rm = TRUE), Annual_Income)) %>%
  ungroup()

# Step 4: Outlier Detection & Winsorization Capping
cap_outliers <- function(x) {
  q95 <- quantile(x, 0.95, na.rm = TRUE)
  q05 <- quantile(x, 0.05, na.rm = TRUE)
  x[x > q95] <- q95
  x[x < q05] <- q05
  return(x)
}

clean_data <- clean_data %>%
  mutate(Annual_Income = cap_outliers(Annual_Income),
         Total_Spend   = cap_outliers(Total_Spend))

# Step 5: Min-Max Normalization & One-Hot Encoding
min_max_scale <- function(x) { (x - min(x)) / (max(x) - min(x)) }

clean_data <- clean_data %>%
  mutate(Annual_Income_Scaled = min_max_scale(Annual_Income),
         Total_Spend_Scaled   = min_max_scale(Total_Spend))

# One-Hot Encoding for categorical features
dummy_model <- dummyVars(~ Membership_Tier, data = clean_data)
encoded_features <- data.frame(predict(dummy_model, newdata = clean_data))
final_dataset <- cbind(clean_data, encoded_features)

# Step 6: Post-Cleaning Statistical Summary
cat("\n--- POST-CLEANING SUMMARY STATISTICS ---\n")
summary(final_dataset)

# Save output
write.csv(final_dataset, "cleaned_ecommerce_data.csv", row.names = FALSE)
cat("\nCleaned dataset successfully exported to 'cleaned_ecommerce_data.csv'.\n")
