# Filter out refactoring types where their values is 0 for each commit ID.
new_data <- simplify2array(apply(filtered_data[2:55], 1, function(x) paste(names(filtered_data[2:55])[x != 0], collapse = " ")))



# Exclude non-performant relevant refactoring types
exclude_ref <- c("Rename Parameter", "Rename Variable", "Rename Method", "Rename Class", "Rename Attribute", "Move Class")
new_filtered_data <- filtered_data[!names(filtered_data) %in% exclude_ref]


## Restructuring data with various refactoring types as columns
# read in the data as a data frame
data <- read.csv("data.csv", header = TRUE)

# create a pivot table using the reshape2 package
library(reshape2)
pivot_table <- dcast(data, Commit.ID ~ Refactoring.Type, value.var = "Refactoring.Type", fun.aggregate = length)

# print the pivot table
print(pivot_table)
