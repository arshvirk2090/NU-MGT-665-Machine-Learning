# Loaded tidyverse, use for manipulation, visualization and analysis
library(tidyverse)

# Load student data from an online source
student_data <- read.csv("https://raw.githubusercontent.com/arshvirk2090/NU-MGT-665-Machine-Learning/main/oulad-students.csv")

# Data Reprocessing: Remove unnecessary columns(variables) that are not needed as these coloumns are not relevant to prediction of students withdrawl from college
student_data <- student_data %>%
  select(-id_student, -date_registration, -date_unregistration)

# Handling missing values: Removing rows with missing values if any has missing data can cuase the model prediction
student_data <- na.omit(student_data)

# Convert categorical variables into factors to label each column with number in a sequence so computer can understand
student_data$gender <- as.factor(student_data$gender)
student_data$region <- as.factor(student_data$region)
student_data$highest_education <- as.factor(student_data$highest_education)
student_data$imd_band <- as.factor(student_data$imd_band)
student_data$age_band <- as.factor(student_data$age_band)
student_data$disability <- as.factor(student_data$disability)

# Convert the final_result column into a binary outcome: 1 if withdrawn, 0 otherwise as this column has four different types of value in it, and we need only two variable to make this model logistic problem
student_data$withdrawn <- ifelse(student_data$final_result == "Withdrawn", 1, 0)

# Remove the original final_result column as we have created above another variable with binary input 
student_data <- student_data %>%
  select(-final_result)

# Split the data into a training set with 90% data as it came with maximum accuracy which is around 70% and a testing set
set.seed(123)
train_index <- sample(1:nrow(student_data), 0.9 * nrow(student_data)) # Select 90% of data for training
train_data <- student_data[train_index, ]
test_data <- student_data[-train_index, ]

# Build a logistic regression model by using general linear model(glm)
model <- glm(withdrawn ~ ., data = train_data, family = binomial)

# Check the summary of the model
summary(model)

# Make predictions on the test dataset
predictions <- predict(model, newdata = test_data, type = "response")

# Convert probabilities to class labels: 1 if probability > 0.5, 0 otherwise
predicted_labels <- ifelse(predictions > 0.5, 1, 0)

# Evaluate the model using a confusion matrix
confusion_matrix <- table(test_data$withdrawn, predicted_labels)
print(confusion_matrix)

# Calculate the accuracy of the model
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", accuracy))
