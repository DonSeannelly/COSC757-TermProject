# This script parses financial data in .csv format for further analysis.
# Developed for COSC 757 in the spring of 2018 by Sean Donnelly

input_file <- "data/SQ Jan 2 - Apr 4.csv" 

# read input
input_data <- read.csv(input_file, header=TRUE, sep=",")
# get number of samples in data
sample_number <- nrow(input_data)


# input_data[col#]
print(input_data)