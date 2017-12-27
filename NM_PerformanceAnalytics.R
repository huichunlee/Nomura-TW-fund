library(PerformanceAnalytics)
library(xts)
library(timeSeries)

#shiny::runGist("https://gist.github.com/rbresearch/5081906")

# function: convert data type of char to double but keep Date as char, then tranform to xts object

data2xts <- function(x){
  Date_temp <- x$Date
  x$Date <- NULL
  x <- sapply(x, as.numeric)
  x <- as.data.frame(x)
  Date_temp <- as.Date(Date_temp)
  rownames(x) <- Date_temp
  x <- as.xts(x)
  x <- na.fill(x, 0)
  return(x)
  
}

# loading data from Nomura funds

Nomura_Price <- read.csv("C:/Users/leeam/Nomura-TW-fund/Nomura_Price2.csv"
                              , header=TRUE)
Nomura_Return_All <- read.csv("C:/Users/leeam/Nomura-TW-fund/Nomura_Return_All.csv"
                              , header=TRUE)
Nomura_Shape <- read.csv("C:/Users/leeam/Nomura-TW-fund/Nomura_Sharp.csv"
                         , header=TRUE)
index_all <- read.csv("C:/Users/leeam/Nomura-TW-fund/index.csv"
                      , header=TRUE)
# call fuction to convert to xts object and set NA = 0

Nomura_Price <- data2xts(Nomura_Price)
Nomura_Return_All <- data2xts(Nomura_Return_All)
Nomura_Shape <- data2xts(Nomura_Shape)
index_all <- data2xts(index_all)

# covert % return to numeric return
Nomura_Return_All <- Nomura_Return_All / 100
index_all <- index_all / 100

charts.PerformanceSummary(Nomura_Return_All, Rf = 0, main = NULL, geometric = TRUE,
                          methods = "StdDev", width = 0, event.labels = NULL, ylog = FALSE,
                          wealth.index = FALSE, gap = 12, begin = c("first", "axis"),
                          legend.loc = "topleft", p = 0.95)

#table.AnnualizedReturns(Nomura_Return_All, scale = 252, Rf = 0, geometric = TRUE,
#                        digits = 4)
result = table.AnnualizedReturns(Nomura_Return_All[,1:5], scale = 252, Rf = 0, geometric = TRUE,
                                 digits = 4)
textplot(result, na.blank=TRUE, numeric.dollar=FALSE)

ID=sample(colnames(Nomura_Price),1);ID
y0=returns(Nomura_Price[,ID])
y=as.xts(y0)
table.AnnualizedReturns(y)

AdjustedSharpeRatio(y,Rf=0)

SharpeRatio(y,Rf=0)
sr1=SharpeRatio(y,Rf=0,FUN="StdDev");sr1
sr2=SharpeRatio(y,Rf=0,FUN="VaR");sr2
sr3=SharpeRatio(y,Rf=0,FUN="ES");sr3

BurkeRatio(y,Rf=0)
OmegaSharpeRatio(y,Rf=0)
CalmarRatio(y)
SterlingRatio(y)
SkewnessKurtosisRatio(y,Rf=0)
BernardoLedoitRatio(y,Rf=0)
KellyRatio(y,Rf=0)
PainRatio(y,Rf=0)
ProspectRatio(y,MAR=quantile(y,0.75)) 
# MAR: the minimum acceptable return