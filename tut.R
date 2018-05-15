library(quantmod);library(tseries);
library(timeSeries);library(forecast);library(xts);

# Pull data from Yahoo finance 
getSymbols('SQ', from='2017-05-01', to='2018-05-01')

# Select the relevant close price series
stock_prices = SQ[,4]

# Compute the log returns for the stock
stock = diff(log(stock_prices),lag=1)
stock = stock[!is.na(stock)]

# Plot log returns 
plot(stock,type='l', main='log returns plot')

# Conduct ADF test on log returns series
print(adf.test(stock))

# Split the dataset in two parts - training and testing
breakpoint = floor(nrow(stock)*(2.9/3))

# Apply the ACF and PACF functions
par(mfrow = c(1,1))
acf.stock = acf(stock[c(1:breakpoint),], main='ACF Plot', lag.max=100)
pacf.stock = pacf(stock[c(1:breakpoint),], main='PACF Plot', lag.max=100)