data <- read.csv("C:/Users/irfan/Downloads/used_cars_data.csv")

# Install if not already installed
install.packages(c("tidyverse", "skimr", "corrplot"))

# Load libraries
library(tidyverse)
library(skimr)
library(corrplot)

# Set working directory (change to your file location)
setwd("C:/your/folder/path")

# Read CSV file
cars <- read.csv("used_cars_data.csv", stringsAsFactors = FALSE)

# View first rows
head(cars)

# Structure of dataset
str(cars)

# Summary statistics
summary(cars)

# Detailed summary
skim(cars)

# Count missing values per column
colSums(is.na(cars))

# Remove units and convert to numeric
cars$Mileage <- as.numeric(gsub(" kmpl| km/kg", "", cars$Mileage))
cars$Engine <- as.numeric(gsub(" CC", "", cars$Engine))
cars$Power <- as.numeric(gsub(" bhp", "", cars$Power))
cars$New_Price <- as.numeric(gsub(" Lakh| Cr", "", cars$New_Price))

current_year <- as.numeric(format(Sys.Date(), "%Y"))
cars$Car_Age <- current_year - cars$Year

ggplot(cars, aes(x = Price)) +
  geom_histogram(bins = 30, fill = "blue") +
  labs(title = "Distribution of Car Prices")

ggplot(cars, aes(x = Year)) +
  geom_histogram(bins = 30, fill = "green") +
  labs(title = "Distribution of Car Manufacturing Year")

cars$Brand <- word(cars$Name, 1)

top_brands <- cars %>%
  count(Brand, sort = TRUE) %>%
  top_n(10)

ggplot(top_brands, aes(x = reorder(Brand, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 Car Brands",
       x = "Brand",
       y = "Count")

ggplot(cars, aes(x = Kilometers_Driven, y = Price)) +
  geom_point(alpha = 0.5) +
  labs(title = "Kilometers Driven vs Price")

# Select numeric columns only
numeric_data <- cars %>%
  select_if(is.numeric)

# Correlation matrix
cor_matrix <- cor(numeric_data, use = "complete.obs")

# Plot correlation
corrplot(cor_matrix, method = "color")
