# Load required library
library(tidyverse)

# Load the data
student_data <- read.csv("https://raw.githubusercontent.com/nasimm48/machine-learning/main/lab-1/data/oulad-students.csv")

# Preprocessing
student_data <- student_data %>%
  select(-id_student, -date_registration, -date_unregistration) # Remove unnecessary columns

# Handle missing values
student_data <- na.omit(student_data)

# Encode categorical variables
student_data$gender <- as.factor(student_data$gender)
student_data$region <- as.factor(student_data$region)
student_data$highest_education <- as.factor(student_data$highest_education)
student_data$imd_band <- as.factor(student_data$imd_band)
student_data$age_band <- as.factor(student_data$age_band)
student_data$disability <- as.factor(student_data$disability)

# Convert final_result to binary outcome
student_data$withdrawn <- ifelse(student_data$final_result == "Withdrawn", 1, 0)

# Remove final_result column
student_data <- student_data %>%
  select(-final_result)

# Split the data into training and testing sets
set.seed(123)
train_index <- sample(1:nrow(student_data), 0.9 * nrow(student_data))
train_data <- student_data[train_index, ]
test_data <- student_data[-train_index, ]

# Build logistic regression model
model <- glm(withdrawn ~ ., data = train_data, family = binomial)

# Check model summary
summary(model)

# Make predictions on the test data
predictions <- predict(model, newdata = test_data, type = "response")

# Convert probabilities to class labels
predicted_labels <- ifelse(predictions > 0.5, 1, 0)

# Evaluate the model
confusion_matrix <- table(test_data$withdrawn, predicted_labels)
print(confusion_matrix)

# Calculate accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", accuracy))
