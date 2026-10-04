# r-data-cleaning-and-preliminary-analysis
Week 1 Task: Data Cleaning, Missing Value Imputation, Feature Transformation, and Preliminary EDA using R.
# Week 1 Task: Data Cleaning and Preliminary Analysis with R

## Project Overview
This repository contains the complete implementation for **Week 1 Task: Data Cleaning and Preliminary Analysis with R**. Raw datasets from real-world systems often contain missing values, structural formatting anomalies, severe outliers, and unencoded categorical features. This project establishes an end-to-end data preprocessing pipeline in R using an E-Commerce Customer & Transaction dataset comprising 5,000 records.

---

## Key Technical Steps

1. **Data Ingestion & Structural Audit**
   - Ingested raw dataset using `tidyverse`.
   - Performed structural and data type verification using `str()`, `summary()`, and `glimpse()`.

2. **Missing Value Imputation**
   - **Continuous Features (`Annual_Income`):** Imputed missing entries using group-wise median values based on `Membership_Tier`.
   - **Categorical Features (`Membership_Tier`):** Imputed missing fields using statistical mode imputation.

3. **Outlier Detection & Capping**
   - Evaluated extreme upper-tail numerical anomalies using Interquartile Range ($IQR$) bounds.
   - Applied 95th-percentile Winsorization capping to stabilize feature variance without record loss.

4. **Normalization & Feature Encoding**
   - Scaled numeric variables (`Annual_Income`, `Total_Spend`) to a $[0, 1]$ range using Min-Max Scaling.
   - Converted nominal categorical attributes into binary feature vectors via One-Hot Encoding (`caret::dummyVars`).

5. **Exploratory Data Analysis (EDA)**
   - Calculated post-cleaning descriptive statistics (Mean, Median, Standard Deviation, Ranges).
   - Executed correlation matrix analysis to extract domain insights.

---

## File Structure

```text
├── README.md                                # Main project documentation
├── script.R                                 # Full executable R preprocessing code
└── Week1_Data_Cleaning_and_Analysis_R.docx  # Comprehensive Word report deliverable
