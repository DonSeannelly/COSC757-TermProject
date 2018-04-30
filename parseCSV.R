# This script parses financial data in .csv format for further analysis.
# Developed for COSC 757 in the spring of 2018 by Sean Donnelly

sq_input_file <- "data/SQ Jan 2 - Apr 4.csv" 
btc_input_file <- "data/BTC Jan 1 - Apr 1.csv"

# read input
sq_input_data <- read.csv(sq_input_file, header=TRUE, sep=",")
btc_input_data <- read.csv(btc_input_file, header=TRUE, sep=",")

sq_input_data[[1]] <- as.Date(sq_input_data[[1]], format="%m/%d/%Y")
btc_input_data[[1]] <- as.Date(btc_input_data[[1]], format="%m/%d/%Y")

# A data frame of BTC only on days SQ was traded
btc_on_trading_days <- subset(btc_input_data, Date %in% sq_input_data$DATE)