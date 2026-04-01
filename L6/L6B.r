# --- Activity 1: Create the Data Frame ---
exam_data <- data.frame(
  name = c('Anastasia', 'Dima', 'Michael', 'Matthew', 'Laura', 'Kevin', 'Jonas'),
  score = c(12.5, 9.0, 16.5, 12.0, 9.0, 8.0, 19.0),
  attempts = c(1, 3, 2, 3, 2, 1, 2)
)
print("--- Initial Data Frame ---")
print(exam_data)

# --- Activity 2: Add a New Column ---
exam_data$qualify <- c('yes', 'no', 'yes', 'no', 'no', 'no', 'yes')
print("--- Data Frame with 'qualify' column ---")
print(exam_data)

# --- Activity 3: Add a New Row ---
new_row <- data.frame(
  name = 'Emily',
  score = 14.5,
  attempts = 1,
  qualify = 'yes'
)
# Bind the new row to the existing data frame
exam_data <- rbind(exam_data, new_row)
print("--- Data Frame after adding Emily ---")
print(exam_data)

# --- Activity 4: Structure, Summary, and Dimensions ---
# Convert character columns to factors to get categorical summaries
exam_data$name <- as.factor(exam_data$name)
exam_data$qualify <- as.factor(exam_data$qualify)

print("--- Structure ---")
str(exam_data)

print("--- Summary ---")
summary(exam_data)

print("--- Rows and Columns ---")
cat("Number of rows:", nrow(exam_data), "\n")
cat("Number of columns:", ncol(exam_data), "\n")
