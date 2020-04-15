library(binancer)
print(paste0('Value of .42 Bitcoins is $', round(0.42 * binance_coins_prices()[symbol == 'BTC']$usd, 2)))

library(jsonlite)
# in HUF: fromJSON("https://api.exchangeratesapi.io/latest?symbols=USD,HUF")$rates$HUF api call
print(paste0('Value of .42 Bitcoins is HUF ', round(0.42 * binance_coins_prices()[symbol == 'BTC']$usd * (fromJSON("https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF")$rates$HUF), 0)))

# other solutions
fromJSON(readLines('https://api.exchangeratesapi.io/latest?base=USD'))


# making script more efficient
library(logger)

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


get_bitcoin_price <- function() {
  tryCatch(binance_coins_prices()[symbol == 'BTC']$usd,
           error = function (e) {get_bitcoin_price()}) # function to call itself
}


btcusdt <- get_bitcoin_price()
log_info('Value of 1 BTC in USDT is: {btcusdt}') 
# lets assert if it is a number
library(checkmate) # adding validations
assert_number(btcusdt, lower = 1000)

usdhuf <- fromJSON("https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF")$rates$HUF
log_info('Value of 1 USD in HUF is: {usdhuf}')
assert_number(usdhuf, lower = 250, upper = 500)


BITCOINS * btcusdt * usdhuf
