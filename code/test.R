# Bounds
a <- 50
b <- 400
# Transform data
y <- log((eggs-a)/(b-eggs))
fit <- ets(y)
fc <- forecast(fit, h=50)
# Back-transform forecasts


fc$mean <- (b-a)*exp(fc$mean)/(1+exp(fc$mean)) + a
fc$lower <- (b-a)*exp(fc$lower)/(1+exp(fc$lower)) + a
fc$upper <- (b-a)*exp(fc$upper)/(1+exp(fc$upper)) + a
fc$x <- eggs
# Plot result on original scale
plot(fc)
