library(jsonlite)
library(logger)
library(checkmate)
log_threshold(TRACE)
#library(devtools)
#install_github('kristofrabay/mr_package')
library(mr.kristof)


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


btcusdt <- get_bitcoin_price()
log_info('Value of 1 BTC in USDT is: {dollar(btcusdt)}') 
assert_number(btcusdt, lower = 1000) 

usdhuf <- fromJSON("https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF")$rates$HUF
log_info('Value of 1 USD in HUF is: {forint(usdhuf)}')
assert_number(usdhuf, lower = 250, upper = 500)


log_eval(forint(BITCOINS * btcusdt * usdhuf))
