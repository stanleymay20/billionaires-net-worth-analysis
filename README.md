# Billionaires' Net Worth Analysis

This project involves a statistical analysis of billionaires' net worth, utilizing a dataset that includes demographic, economic, and financial details of billionaires from around the world. The primary goal is to explore patterns in net worth distribution and identify key predictors of wealth, while providing business insights.

## Table of Contents
- [Project Description](#project-description)
- [Business Questions](#business-questions)
- [Hypotheses](#hypotheses)
- [Dataset](#dataset)
- [Data Cleaning](#data-cleaning)
- [Analysis and Results](#analysis-and-results)
- [How to Run the Project](#how-to-run-the-project)
- [Conclusion](#conclusion)
- [Limitations](#limitations)
- [Future Work](#future-work)

## Project Description

This project conducts a thorough statistical analysis on a dataset containing information on billionaires worldwide. The analysis involves exploring descriptive statistics, hypothesis testing, regression analysis, and logistic regression to understand the key factors influencing billionaires' net worth.

## Business Questions

1. What is the distribution of billionaires' net worth?
2. How does age, industry, gender, and other demographic factors affect a billionaire's net worth?
3. Can we predict whether a billionaire belongs to the technology industry based on their age, gender, and net worth?

## Hypotheses

- **Null Hypothesis (H0):** There is no significant difference in net worth based on gender, age, and industry.
- **Alternative Hypothesis (H1):** There is a significant difference in net worth based on gender, age, and industry.

## Dataset

The dataset contains data on 2,640 billionaires including the following fields:
- `rank`
- `finalWorth` (Net worth in billions)
- `age`
- `gender`
- `industry`
- `country`
- And several other fields.

Source: [Billionaires Statistics Dataset on Kaggle](https://www.kaggle.com/datasets/nelgiriyewithana/billionaires-statistics-dataset?resource=download)

## Data Cleaning

Before conducting analysis, the following steps were taken to clean and prepare the data:
- Missing values in key fields (e.g., age, gender) were imputed.
- Non-numeric values in the `finalWorth` column were cleaned and converted to numeric format.
- Categorical data was factorized for statistical modeling.

## Analysis and Results

### Descriptive Statistics

A descriptive analysis was performed on the dataset. Key statistics include:
- Mean Net Worth: \$4.6 billion
- Median Net Worth: \$2.3 billion
- Distribution of net worth was highly skewed, with a small number of billionaires holding the majority of wealth.

### Hypothesis Testing

A t-test was conducted to examine differences in net worth based on gender. Results showed that the mean net worth for male and female billionaires was not significantly different (p-value = 0.437).

### Regression Analysis

A multiple linear regression was conducted to assess the impact of age, gender, and industry on net worth. Significant predictors include:
- **Age**: Older individuals tend to have a higher net worth.
- **Industry**: Certain industries (e.g., Technology, Healthcare) were associated with higher/lower net worth.

### Logistic Regression

Logistic regression was used to predict whether a billionaire belonged to the technology industry based on their age, gender, and net worth. The model showed that age and gender were significant predictors, while net worth was not.

## How to Run the Project

1. Clone the repository:
    ```bash
    git clone https://github.com/stanleymay20/billionaires-net-worth-analysis.git
    ```

2. Navigate to the project directory:
    ```bash
    cd billionaires-net-worth-analysis
    ```

3. Install required packages in RStudio:
    ```r
    install.packages("dplyr")
    install.packages("ggplot2")
    install.packages("car")
    ```

4. Run the R scripts to perform analysis:
    ```r
    source('analysis_script.R')
    ```

## Conclusion

The analysis reveals several important factors influencing billionaires' net worth. Age and industry are significant predictors, while gender has no significant impact. The logistic regression model demonstrates a reasonable ability to predict whether a billionaire belongs to the technology industry.

## Limitations

- The dataset contains missing values for some variables, which were imputed using statistical techniques.
- The regression models explain only a small portion of the variance in net worth, indicating that many factors remain unexplained.
- Potential for unobserved confounders in the dataset.

## Future Work

- Use advanced machine learning models (e.g., Random Forest, XGBoost) to improve predictive power.
- Explore additional variables, such as economic indicators and global market trends, to enhance the analysis.
- Conduct a deeper analysis on regional and industry-specific differences in wealth distribution.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
