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

## TODO the Binance API is a bit of a mess .. need to add retries
btcusdt <- binance_coins_prices()[symbol == 'BTC']$usd
log_info('Value of 1 BTC in USDT is: {btcusdt}') 

usdhuf <- fromJSON("https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF")$rates$HUF
log_info('Value of 1 USD in HUF is: {usdhuf}')


BITCOINS * btcusdt * usdhuf
