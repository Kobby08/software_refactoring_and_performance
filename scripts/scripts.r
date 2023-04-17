## 1. Filtering out commits to be used for benchmarking
# Filter out refactoring types where their values is 0 for each commit ID.
new_data <- simplify2array(apply(filtered_data[2:55], 1, function(x) paste(names(filtered_data[2:55])[x != 0], collapse = " ")))

# Exclude non-performant relevant refactoring types
exclude_ref <- c("Rename Parameter", "Rename Variable", "Rename Method", "Rename Class", "Rename Attribute", "Move Class")
new_filtered_data <- filtered_data[!names(filtered_data) %in% exclude_ref]

## 2. Restructuring data with various refactoring types as columns
# read in the data as a data frame
data <- read.csv("data.csv", header = TRUE)
# create a pivot table using the reshape2 package
library(reshape2)
pivot_table <- dcast(data, Commit.ID ~ Refactoring.Type, value.var = "Refactoring.Type", fun.aggregate = length)
# print the pivot table
print(pivot_table)


## 3. Counting Refactoring Types in each project
# Load data from a CSV file
data <- read.csv("your_file.csv")
# Replace "column_name" with the name of the column you want to count the frequency of
ref_types_freq <- table(data$column_name)
# Print the frequency table
print(ref_types_freq)


## 4. Finding performance refactorings that exists in the project repo
# Load data of all refactoring found in issue tracker
data <- read.csv("your_file.csv")
perf_commits_found_in_project <- c("list of all perf commits found in project repo")
#  filter the data to include only the specified commit IDs
perf_ref_in_project <- data[data$Commit.ID %in% perf_commits_found_in_project, ]
# write to a specific location
write.csv(perf_ref_in_project, "your_location", row.names = FALSE)
