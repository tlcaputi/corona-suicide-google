library(forecast)
library(dplyr)
library(imputeTS)
library(lubridate)

original_ts <- c(
  24.823106, 39.276669, 78.933643, 69.526353, 64.951392, 51.299861, 28.700566,
  31.330683, 40.390386, 31.558028, 40.047272, 55.651414, 40.456689, 19.730653,
  20.095277, 32.304189, 29.414217, 73.840982, 46.735376, 42.013055, 33.871406,
  22.598197, 14.123539,  5.768710,  9.910225, 20.080413, 27.725606, 24.666278,
  11.090389, 22.776456, 38.135226, 42.785740, 36.460034, 23.725230, 32.894998,
  35.734966, 19.081198, 30.565233, 22.465126, 19.575703, 19.137272, 18.782175,
  21.197170, 21.578810, 13.920377, 28.452585, 22.311620, 24.185756, 21.299391,
  29.302505, 19.010816, 30.254398, 12.925249, 25.668074, 21.784188, 16.017535,
  13.513164,  5.213665,  5.364693, 19.192563,  9.379560,  5.324828,        NA,
  21.467884, 18.958708, 15.805931, 23.913180, 15.200693, 17.328355, 26.661457,
  29.566244,  8.138841, 20.271213, 23.803847, 17.798417, 10.151627, 15.133365,
  20.405264, 10.164986,  7.704902, 23.343796, 14.825165, 30.198858, 10.419265,
  12.819321, 28.342212, 15.866760, 26.655029, 20.563993,  5.133502
)
train_number <- 58



# Recommended method

# Run model
train_ts1 <- original_ts[1:train_number]
test_ts1 <-  original_ts[(train_number + 1):length(original_ts)]
train_ts1_kalman <- na_kalman(ts(train_ts1, freq = 365.25, start = decimal_date(ymd("2020-01-15"))), model = "auto.arima")
mod1 <- auto.arima(train_ts1_kalman, lambda = 0, approximation = T)
fitted1 <- forecast(mod1, h = length(test_ts1), bootstrap = T, npaths = 1000)
out1 <- data.frame(
  "actual"  = as.numeric(test_ts1),
  "fitted"  = fitted1$mean,
  "lo95"    = fitted1$lower[,2],
  "hi95"    = fitted1$upper[,2]
)
out1$pctdiff <- out1$actual / out1$fitted
out1$pctdiff <- out1$actual / out1$fitted
out1$pctdiff_lo95 <- out1$actual / out1$hi95
out1$pctdiff_hi95 <- out1$actual / out1$lo95


set.seed(1234)
# Logit method

# Scale to be between 0 and 1, bc logit is undefined for anything else
original_ts_scaled <- original_ts / (max(original_ts, na.rm = T) * 1.1)

# logit transform
original_ts_logit <- gtools::logit(original_ts_scaled)

# Run model
train_ts2 <- original_ts_logit[1:train_number]
test_ts2 <-  original_ts_logit[(train_number + 1):length(original_ts_logit)]
train_ts2_kalman <- na_kalman(ts(train_ts2, freq = 365.25, start = decimal_date(ymd("2020-01-15"))), model = "auto.arima")
mod2 <- auto.arima(train_ts2_kalman, approximation = T)
fitted2 <- forecast(mod2, h = length(test_ts2), bootstrap = T, npaths = 1000)
out2 <- data.frame(
  "actual"  = gtools::inv.logit(as.numeric(test_ts2)),
  "fitted"  = gtools::inv.logit(fitted2$mean),
  "lo95"    = gtools::inv.logit(fitted2$lower[,2]),
  "hi95"    = gtools::inv.logit(fitted2$upper[,2])
)
out2$pctdiff <- out2$actual / out2$fitted - 1
out2$pctdiff_lo95 <- out2$actual / out2$hi95 - 1
out2$pctdiff_hi95 <- out2$actual / out2$lo95 - 1


print(original_ts_logit)
print(train_ts2)
print(test_ts2)
print(out2$fitted)
print(out2$pctdiff)

mean(out1$pctdiff, na.rm = T)
mean(out2$pctdiff, na.rm = T)



print("done")
