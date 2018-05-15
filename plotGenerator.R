# Get quantmod
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}
# Get pipe operator
if (!require("magrittr")) {
  install.packages("magrittr")
  library(magrittr)
}
if (!require("e1071")) {
  install.packages("e1071")
  library(e1071)
}


getSymbols(c("SQ","BTC-USD"), src="yahoo",from="2017-05-01",to="2018-05-01")


# Plot graphs

plot(`BTC-USD`[, "BTC-USD.Close"],main="BTC-USD")
candleChart(`BTC-USD`,up.col="black",dn.col="red",theme="white")
addSMA(n = c(20, 50, 100))

plot(SQ[, "SQ.Close"],main="SQ")
candleChart(SQ,up.col="black",dn.col="red",theme="white")
addSMA(n = c(20, 50, 100))


# Filter days to stock exchange trading days

##SQ[[1]] <- as.Date(SQ[[1]], format="%m/%d/%Y")
##`BTC-USD`[[1]] <- as.Date(`BTC-USD`[[1]], format="%m/%d/%Y")

stocks <- merge(`BTC-USD`,SQ,join="inner")
stocks <- stocks[, +which(names(stocks) %in% c("BTC.USD.Close", "SQ.Close"))]


# Calculate and plot returns

stock_return = apply(stocks, 1, function(x) {x / stocks[1,]}) %>% 
  t %>% as.xts

plot(as.zoo(stock_return), screens = 1, lty = 1:3, xlab = "Date", ylab = "Return")
legend("topleft", c("BTC-USD", "SQ"), lty = 1:3, cex = 0.5)

# Calculate and plot log differences

stock_change = stocks %>% log %>% diff

plot(as.zoo(stock_change), screens = 1, lty = 1:3, xlab = "Date", ylab = "Log Difference")
legend("topleft", c("BTC-USD", "SQ"), lty = 1:3, cex = 0.5)

# Stagger the data for regression

SQ_staggered_returns <- stock_return$SQ.Close[-c(1),]
BTC_staggered_returns <- head(stock_return$BTC.USD.Close,-1)

# More plots

scatter.smooth(x=BTC_staggered_returns, y=SQ_staggered_returns, main="SQ Returns ~ BTC Returns")

par(mfrow=c(1, 2))  # divide graph area in 2 columns
plot(density(SQ_staggered_returns), main="Density Plot: SQ Returns", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(SQ_staggered_returns), 2)))  # density plot for SQ
polygon(density(SQ_staggered_returns), col="red")

plot(density(BTC_staggered_returns), main="Density Plot: BTC Returns", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(BTC_staggered_returns), 2)))  # density plot for BTC
polygon(density(BTC_staggered_returns), col="red")

# Examine correlation

cor(BTC_staggered_returns, SQ_staggered_returns)

# Build regression model




