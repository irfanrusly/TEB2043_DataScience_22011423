# Load required library for K-NN
library(class)

# ==========================================
# ACTIVITY 1: Linear Regression (Theoph)
# ==========================================
print("--- Activity 1: Linear Regression ---")

# 1a. Create the linear model predicting Dose based on Wt (Weight)
# Theoph is a built-in dataset, so no importing is necessary
linear_model <- lm(Dose ~ Wt, data = Theoph)

# 1b. Output the linear model summary for discussion
print("--- Model Summary ---")
print(summary(linear_model))

# 1c. Visualize the linear regression
# This will generate a plot in your RStudio Plots pane
plot(Theoph$Wt, Theoph$Dose,
     main = "Linear Regression: Dose vs Weight",
     xlab = "Weight (kg)",
     ylab = "Dose (mg/kg)",
     pch = 16, col = "blue")

# Add the regression line to the plot
abline(linear_model, col = "red", lwd = 2)

# 1d. Predict the dose for weights 90kg, 95kg, and 100kg
new_weights <- data.frame(Wt = c(90, 95, 100))
predictions <- predict(linear_model, newdata = new_weights)

print("--- Dose Predictions ---")
print(data.frame(Weight_kg = new_weights$Wt, Predicted_Dose_mg_kg = predictions))


# ==========================================
# ACTIVITY 2: K-NN Classifier (ChickWeight)
# ==========================================
print("--- Activity 2: K-NN Classifier ---")

# 2a. Prepare the dataset
set.seed(123) # Set a seed so your results are reproducible
cw_data <- ChickWeight

# Scale the numeric features (weight and Time) so they contribute equally to the algorithm
features <- scale(cw_data[, c("weight", "Time")])
target <- cw_data$Diet

# Split data into training (80%) and testing (20%) sets
sample_index <- sample(1:nrow(cw_data), 0.8 * nrow(cw_data))
train_x <- features[sample_index, ]
test_x <- features[-sample_index, ]
train_y <- target[sample_index]
test_y <- target[-sample_index]

# 2b. Loop to find the optimal K value (testing K from 1 to 20)
accuracy <- numeric(20)
for(k in 1:20) {
  pred <- knn(train = train_x, test = test_x, cl = train_y, k = k)
  accuracy[k] <- sum(pred == test_y) / length(test_y)
}

optimal_k <- which.max(accuracy)
cat("The optimal K value is:", optimal_k, "with an accuracy of:", round(max(accuracy)*100, 2), "%\n\n")

# 2c. Perform KNN with the optimal K and generate the confusion matrix
final_pred <- knn(train = train_x, test = test_x, cl = train_y, k = optimal_k)

print("--- Confusion Matrix ---")
conf_matrix <- table(Predicted = final_pred, Actual = test_y)
print(conf_matrix)
