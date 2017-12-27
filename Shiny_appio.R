install.packages('rsconnect',"C:/Temp")
rsconnect::setAccountInfo(name='leeam', token='8E606F8F1EE7EFBC9834D34A563867FD', secret='hWPH6zY/1zwbDJWg4H7MzVXesEZK/ksj686Jabqw')

library(shiny)
library(rsconnect)
rsconnect::deployApp('C:/Users/leeam/Nomura-TW-fund')
