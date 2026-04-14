# layoffs-data-cleaning-sql
SQL project focused on cleaning and analyzing layoffs dataset using data preprocessing, window functions, and exploratory data analysis techniques.

## Overview

This project focuses on cleaning and analyzing a real-world layoffs dataset using SQL. It demonstrates data preprocessing techniques, handling missing values, removing duplicates, and performing exploratory data analysis (EDA).

---

## Objectives

- Clean raw data for accurate analysis
- Remove duplicates using SQL window functions
- Standardize inconsistent values
- Handle missing data effectively
- Perform exploratory data analysis to identify trends

---

## Dataset

- layoffs.csv
- Contains information about layoffs across companies, industries, and countries

---

## Data Cleaning Steps

- Created staging tables to preserve raw data
- Removed duplicate records using ROW_NUMBER()
- Standardized text data (company, industry, country)
- Converted date formats to proper DATE type
- Handled missing values using joins and updates
- Dropped unnecessary columns

---

## SQL Concepts Used

- Window Functions (ROW_NUMBER, DENSE_RANK)
- Common Table Expressions (CTE)
- Joins
- Aggregations (SUM, MAX)
- Date functions
- String functions (TRIM, SUBSTRING)

---

## Exploratory Data Analysis

- Total layoffs by industry
- Year-wise layoffs trends
- Monthly layoffs analysis
- Company-wise layoffs ranking
- Top companies with highest layoffs

---

## Key Insights

- Certain industries had significantly higher layoffs
- Layoffs increased in specific years
- Some companies consistently ranked in top layoffs

---

## How to Use

1. Import layoffs.csv into your SQL database
2. Run "Data Cleaning.sql"
3. Run "Exploratory Data Analysis.sql"

---

## Project Highlights

- End-to-end data cleaning pipeline
- Real-world dataset analysis
- Strong use of SQL concepts
- Practical business insights

---

## Future Improvements

- Create dashboards (Power BI / Tableau)
- Automate pipeline
- Add more datasets for comparison
