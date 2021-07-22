##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##
## Forecasting in R: Smoothing Methods ####
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##
# exploring the different ways to do forecasting, with commentary
# ref: https://www.youtube.com/watch?v=cZRMFNTreQI
# data set: https://www.kaggle.com/rtatman/us-candy-production-by-month

df <- read.csv('Data/candy_production.csv', header=TRUE)
head(df)

#create a date column out of the date (not required for forecasting)

#Symbol 	Meaning 	              Example
# %d 	    day as a number (0-31) 	01-31
# %a      abbreviated weekday     Mon
# %A 	    abbreviated weekday     Monday
# %m 	    month (00-12)         	00-12
# %b      abbreviated month       Jan
# %B 	    unabbreviated month     January
# %y      2-digit year            07
# %Y 	    4-digit year 	          2007

"1972-01-01"
df$Date <- as.Date(df$observation_date, "%Y-%m-%d")
#use as.POSIXct for data series with hours||min||sec and timezones
# ts doesn't explicitly use it, but it helps for filtering data

# turn into a time series
# frequency is the number of data points per year
dfts <- ts(df$IPG3113N, frequency=12, start=c(1972,1))
dfts

##%%%%%%%%%%%%%%%%%%%%%%##
### Decomposing       ####
##%%%%%%%%%%%%%%%%%%%%%%##

components_dfts <- decompose(dfts)
plot(components_dfts)
#see the seasonal component in 2010:
plot(components_dfts$seasonal, xlim=c(2010,2011))

##%%%%%%%%%%%%%%%%##
### Fitting    #####
##%%%%%%%%%%%%%%%%##

#Estimated HoltWinters fitting
HW1 <- HoltWinters(dfts)

HW1
# alpha: 0.602278
# beta : 0.003181854 
# gamma: 0.585786 - seasonality
# Coefficients:
# a   118.4294136 #level at end 
# b     0.1143089 # slope at end
# s1    0.6558481 #additive seasonality offset for s1 (month1 here)


# Custom HoltWinters fitting
HW2 <- HoltWinters(dfts, alpha=0.2, beta=0.1, gamma=0.1)
#can remove all seasonality functionalization with gamma=FALSE
# --however, even if no expected seasonality, play with leaving gamma in.
#will do exponential smoothing if beta=FALSE (rarely used)

#Visually evaluate the fits
plot(dfts, ylab="candy production", xlim=c(2013,2018))
lines(HW1$fitted[,1], lty=2, col="blue")
lines(HW2$fitted[,1], lty=2, col="red")

##%%%%%%%%%%%%%%%%%%%%%%%%%%%##
## Predict future points   ####
##%%%%%%%%%%%%%%%%%%%%%%%%%%%##
# https://rdrr.io/r/stats/predict.HoltWinters.html
#   predict(<HW fit>, <elements into the future>, 
#            prediction.interval=TRUE (turns on confidence intervals), 
#            level=<confidence level>)
HW1.pred <- predict(HW1, 24, prediction.interval = TRUE, level=0.95)

HW1
# columns: fit, upr, lwr

#Visually evaluate the prediction
#2008.5 is halfway through 2008 (June)
plot(dfts, ylab="candy production", xlim=c(2008.5,2020))
lines(HW1$fitted[,1], lty=2, col="blue")
lines(HW1.pred[,1], col="red")
lines(HW1.pred[,2], lty=2, col="orange")
lines(HW1.pred[,3], lty=2, col="orange")

##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
## Estimated Holt-Winters with multiplicative seasonality  ####
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

HW3 <- HoltWinters(dfts, seasonal = "multiplicative")
HW3
#now s1, s2, etc are the multiplied factor versus the level for that season

HW3.pred <- predict(HW3, 24, prediction.interval = TRUE, level=0.95)
#Visually evaluate the fits
plot(dfts, ylab="candy production", xlim=c(2008.5,2020))
lines(HW3$fitted[,1], lty=2, col="blue")
lines(HW3.pred[,1], col="red")
lines(HW3.pred[,2], lty=2, col="orange")
lines(HW3.pred[,3], lty=2, col="orange")
#in this case, multiplicative has much worse confidence bounds.  additive was better


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
### Using the forecast function ####
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
library(forecast)
# https://rdrr.io/github/ttnsdcn/forecast-package/man/forecast.HoltWinters.html

# This function calls predict.HoltWinters and constructs an object of 
# class "forecast" from the results.
# forecast does the same as predict, but enables multiple levels and 
#    plots more automatically
#  forecast also provides $residuals to help evaluate the quality of the fit

HW1_for <- forecast(HW1, h=24, level=c(80,95))
plot(HW1_for, xlim=c(2008.5, 2020))
lines(HW1_for$fitted, lty=2, col="purple")
HW1_for$residuals

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
### HW Forcast Evaluation    #######
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

acf(HW1_for$residuals, lag.max=20, na.action=na.pass)
# na.pass is required because the last value of $residuals is always NA
# looking for bars way outside the blue dashes
Box.test(HW1_for$residuals, lag=20, type="Ljung-Box")
# want a p-value > 0.05 (95% chance values are independent)
hist(HW1_for$residuals)
# want the residuals to look normally distributed

