# Get quantmod
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}
# Get me my beloved pipe operator!
if (!require("magrittr")) {
  install.packages("magrittr")
  library(magrittr)
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




