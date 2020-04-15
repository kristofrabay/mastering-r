library(binancer)
library(jsonlite)
library(logger)
library(checkmate)
library(scales)
log_threshold(TRACE)


BITCOINS <- 0.42
log_info('Number of Bitcoins: {BITCOINS}') 


# while (TRUE) {
#   tryCatch(binance_coins_prices()[symbol == 'BTC']$usd,
#            error = function(e) {
#              binance_coins_prices()[symbol == 'BTC']$usd
#            })
#   
#   break
# }


get_bitcoin_price <- function(retried = 0) {
  tryCatch(binance_coins_prices()[symbol == 'BTC']$usd,
           error = function (e) {
             # exponential backoff retries
             Sys.sleep(1 + retried ^ 2)
             get_bitcoin_price(retried = retried + 1)
           })
}


btcusdt <- get_bitcoin_price()
log_info('Value of 1 BTC in USDT is: {dollar(btcusdt)}') 
assert_number(btcusdt, lower = 1000) 

forint <- function(x) {dollar(x, suffix = "Ft", prefix = NULL)}

usdhuf <- fromJSON("https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF")$rates$HUF
log_info('Value of 1 USD in HUF is: {forint(usdhuf)}')
assert_number(usdhuf, lower = 250, upper = 500)


log_eval(forint(BITCOINS * btcusdt * usdhuf))
