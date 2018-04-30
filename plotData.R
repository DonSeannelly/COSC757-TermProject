# This script utilizes parseCSV.R to read SQ and BTC financial data into memory.
# It then constructs a scatter plot, box plot, and density plot from the data.
#
# Developed for COSC 757 in the spring of 2018 by Sean Donnelly

source(file="parseCSV.R")

scatter.smooth(x=btc_on_trading_days$Close, y=sq_input_data$CLOSING.PRICE, main="SQ Close ~ BTC Close")  # scatterplot