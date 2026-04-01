# Load necessary libraries
library(readxl)
library(readr)
library(dplyr)
library(tidyr)

# ==========================================
# ACTIVITY 1: Import and Clean Data
# ==========================================

# 1a. Import datasets from excel and csv
ufo_data <- read_excel("uforeport.xls")
titanic_data <- read_csv("titanic.csv")

# 1b. Clean UFO Data (Managing NAs and Empty Cells)
# Replace empty strings with NA, drop rows missing critical location data, and arrange by State
ufo_clean <- ufo_data %>%
  mutate(across(everything(), ~na_if(as.character(.), ""))) %>% 
  drop_na(City, State) %>% 
  arrange(State)

# 1c. Clean Titanic Data (Managing NAs and Empty Cells)
# Replace missing ages with the median age, and filter out missing embarkation towns
titanic_clean <- titanic_data %>%
  mutate(age = if_else(is.na(age), median(age, na.rm = TRUE), age)) %>%
  filter(!is.na(`embark town`))

# ==========================================
# ACTIVITY 2: Filtering, Searching, Arranging & Insights
# ==========================================

# Insight A: Titanic Survival Rates by Embark Town and Class
# This directly addresses the expected output example in the lab manual
titanic_insights <- titanic_clean %>%
  group_by(`embark town`, class) %>%
  summarise(
    total_passengers = n(),
    survivors = sum(survived),
    survival_rate_percent = (survivors / total_passengers) * 100,
    .groups = 'drop'
  ) %>%
  arrange(desc(survival_rate_percent)) # Arrange from highest survival rate to lowest

print("--- Insight 1: Titanic Survival Rates ---")
print(titanic_insights)

# Insight B: Top 5 Most Common UFO Shapes
# Filtering out unknown shapes and arranging data to find the most frequent reports
ufo_insights <- ufo_clean %>%
  filter(!is.na(`Shape Reported`)) %>%
  group_by(`Shape Reported`) %>%
  summarise(report_count = n()) %>%
  arrange(desc(report_count))

print("--- Insight 2: Top UFO Shapes Reported ---")
print(head(ufo_insights, 5))

# ==========================================
# EXPORTING DATA
# ==========================================

# Save the cleaned and prepared data into new CSV files
write_csv(titanic_clean, "titanic_cleaned.csv")
write_csv(ufo_clean, "uforeport_cleaned.csv")
print("Cleaned data successfully exported to working directory.")
