# Predicting Student Withdrawal from College

This R script utilizes logistic regression to predict whether a student will withdraw from college based on various demographic and educational factors. The dataset used for training and testing is sourced from an online repository.

## Data Preprocessing

- Removed unnecessary columns such as `id_student`, `date_registration`, and `date_unregistration`.
- Handled missing values by removing rows with missing data.
- Converted categorical variables (`gender`, `region`, `highest_education`, `imd_band`, `age_band`, `disability`) into factors.
- Converted the `final_result` column into a binary outcome: 1 if withdrawn, 0 otherwise.

## Model Building

- Split the data into a training set (90% of the data) and a testing set.
- Built a logistic regression model using the `glm` function from the `stats` package.
- Evaluated the model using the test dataset.
  
## Evaluation

- Made predictions on the test dataset and converted probabilities to class labels.
- Evaluated the model using a confusion matrix to assess its performance.
- Calculated the accuracy of the model.

## Libraries Used

- `tidyverse`: Used for data manipulation, visualization, and analysis.

## Instructions for Use

1. Clone the repository.
2. Ensure you have R and RStudio installed.
3. Install the necessary packages: `install.packages("tidyverse")`.
4. Run the R script (`predict_student_withdrawal.R`) in RStudio.
5. View the model summary, confusion matrix, and accuracy metrics to evaluate the model's performance.

## Author

[Arsh Virk]

