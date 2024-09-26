# Load required libraries
library(tidyverse)
library(dplyr)
library(ggplot2)

# Load the dataset
data <- read.csv("Billionaires Statistics Dataset.csv")

# Check for missing values
summary(data)

# Handle missing values (example: replace missing age with median)
data$age[is.na(data$age)] <- median(data$age, na.rm = TRUE)

# Convert categorical variables to factors
data$gender <- as.factor(data$gender)
data$industry <- as.factor(data$industries)
data$country <- as.factor(data$country)

# Remove any outliers from the finalWorth column for cleaner visualization
qnt <- quantile(data$finalWorth, probs = c(0.25, 0.75), na.rm = TRUE)
caps <- quantile(data$finalWorth, probs = c(0.01, 0.99), na.rm = TRUE)
IQR <- qnt[2] - qnt[1]

data <- data %>%
  filter(finalWorth >= caps[1] & finalWorth <= caps[2])

# Creating a histogram of billionaire net worth
ggplot(data, aes(x = finalWorth)) + 
  geom_histogram(bins = 30, fill = "darkgrey", color = "black") +
  labs(title = "Distribution of Billionaires' Net Worth", 
       x = "Net Worth (in billions)", 
       y = "Count") +
  theme_minimal() +
  coord_cartesian(xlim = c(0, 15000)) +  # Adjust the limit based on actual data to focus on common values
  theme(panel.grid.major = element_blank(),  # Remove major grid lines
        panel.grid.minor = element_blank())   # Remove minor grid lines

# Scatter plot of Age vs Net Worth
ggplot(data, aes(x = age, y = finalWorth)) + 
  geom_point(alpha = 0.5, size = 2, color = "darkgrey") +  # Adjust transparency (alpha) and point size
  labs(title = "Age vs Net Worth", 
       x = "Age", 
       y = "Net Worth (in billions)") +
  theme_minimal() +
  coord_cartesian(ylim = c(0, 15000)) +  # Set y-axis limits to focus on main distribution
  theme(panel.grid.major = element_blank(),  # Remove major grid lines
        panel.grid.minor = element_blank())   # Remove minor grid lines

# Remove outliers beyond the 99th percentile
q99 <- quantile(data$finalWorth, 0.99)
# Select seven key industries to focus on
key_industries <- c("Technology", "Finance & Investments", "Healthcare", "Manufacturing", 
                    "Media & Entertainment", "Real Estate", "Energy")

data_filtered_key <- data_filtered %>% filter(industry %in% key_industries)

# Boxplot: Net Worth by Key Industries with cleaner visualization
ggplot(data_filtered_key, aes(x = industry, y = finalWorth)) +
  geom_boxplot(fill = "darkgrey", outlier.shape = NA, width = 0.6) +  # Wider boxplot for better visualization
  coord_cartesian(ylim = c(0, q99)) +  # Limit y-axis to remove extreme outliers
  theme_minimal() +
  labs(title = "Net Worth by Key Industries (Filtered)", 
       x = "Industry", y = "Net Worth (in billions)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels
        plot.title = element_text(size = 14, face = "bold"))  # Bold title for emphasis


# Bar plot: Average Net Worth by Gender with black and grey colors
ggplot(data, aes(x = gender, y = finalWorth, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("F" = "darkgrey", "M" = "black")) +
  theme_minimal() +
  labs(title = "Average Net Worth by Gender", 
       x = "Gender", y = "Average Net Worth (in billions)") +
  theme(plot.title = element_text(size = 14, face = "bold"))

# Hypothesis testing: T-test for gender and net worth
t.test(finalWorth ~ gender, data = data)

# Hypothesis testing: ANOVA for industry and net worth
anova_model <- aov(finalWorth ~ industry, data = data)
summary(anova_model)

# Example: Combine industries with fewer than a certain number of observations
data$industry_combined <- ifelse(table(data$industry)[data$industry] < 10, "Other", as.character(data$industry))

# Update table
table_gender_industry_combined <- table(data$gender, data$industry_combined)

# Perform Chi-Square test on the updated table
chisq.test(table_gender_industry_combined)
chisq.test(table_gender_industry, simulate.p.value = TRUE, B = 10000)
# Linear regression model
lm_model <- lm(finalWorth ~ age + gender + industry + country, data = data)
summary(lm_model)

# Diagnostic Plots
par(mfrow = c(2, 2))
plot(lm_model)
# Logistic regression model to predict if the billionaire is in the technology industry
data$tech_industry <- ifelse(data$industry == "Technology", 1, 0)
logit_model <- glm(tech_industry ~ age + gender + finalWorth, data = data, family = binomial)
summary(logit_model)

# Plot ROC curve
install.packages("pROC")
library(pROC)
roc_curve <- roc(data$tech_industry, fitted(logit_model))
plot(roc_curve, main = "ROC Curve for Logistic Regression")
