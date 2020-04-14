pacman::p_load(gtools)


library(forecast)
library(xts)
library(car)
library(imputeTS)
range01 <- function(x){(x-min(x))/(max(x)-min(x))*100}


ROOTPATH <- "C:/Users/tcapu/Google Drive/Research_/Completed/Suicide"
setwd(ROOTPATH)

###### Process Google data
# dir<- setwd("/Users/ericleas/Google Drive/Public Health Papers (Ayers, Dredze, Leas)/Suicide/suicide_trends")

temp <- dir("./suicide_trends", pattern = "*.csv", full.names = T)
f <- lapply(temp, read.table, header = T, sep = ",", skip = 1)
mid <- Reduce(function(x,y) merge(x,y, all = TRUE), f)

period1 <- 2193:nrow(f)

d <- mid[period1 , c(
  "how.to.kill.yourself",
  "commit.suicide",
  "how.to.suicide",
  "suicide.hotline",
  "suicide.prevention",
  "murder.suicide",
  "teen.suicide",
  "suicide.video",
  "facebook.suicide",
  "suicide.quotes",
  "suicide.note",
  "suicidal",
  "suicide.statistics",
  "suicide.song",
  "suicide.definition",
  "suicide.bridge",
  "how.to.commit.suicide")]

d <- range01(d)

for(i in 1:ncol(d)){
d[,i] 	<- ifelse(d[,i] == 0,NA,d[,i])
}

d$date 	<- as.Date(as.character(mid[period1,1]))




#j <- na.kalman(ts(logit(d$suicide.hotline/100), end = as.Date("2017-3-31")), model = "auto.arima")
d$teen.suicide <-gtools::inv.logit( na.kalman(ts(logit(d$teen.suicide/100)), model = "auto.arima"))
j <- ts(logit(d$teen.suicide), end = as.Date("2017-3-31"))

nsims <- 10000
mod <- auto.arima(j, stepwise=FALSE, approximation=FALSE)

sim <- matrix(NA, nrow=6, ncol=nsim)
for(i in 1:nsim)
sim[,i] <- simulate(mod, nsim=6, future=TRUE, bootstrap=TRUE)



cast<- forecast(mod, h = 21, bootstrap = TRUE, npaths = 1000)
ddd <- data.frame(mean = gtools::inv.logit(cast$mean),
lower =  gtools::inv.logit(cast$lower[,2]),
upper =  gtools::inv.logit(cast$upper[,2]),
total = d[d$date > as.Date("2017-3-31") & d$date <= as.Date("2017-3-31")+ 21, "teen.suicide"],
date  = d[d$date > as.Date("2017-3-31") & d$date <= as.Date("2017-3-31")+ 21,"date"])

ddd$eff <- ((ddd$total - ddd$mean)/ddd$mean)*100
ddd$Hi  <- ((ddd$total - ddd$lower)/abs(ddd$lower))*100
ddd$Lo  <- ((ddd$total - ddd$upper)/abs(ddd$upper))*100
















d<- read.csv("SuicideMinusSquadHernandez.csv", header = T)

d$date 	<- as.Date(strptime(d[,1], "%m/%d/%y"))






j <- ts(d$suicide, end = as.Date("2017-3-31"))


mod <- auto.arima(j, stepwise=FALSE, approximation=FALSE)

cast<- forecast(mod, h = 30, bootstrap = TRUE, npaths = 1000)
ddd <- data.frame(mean = cast$mean,
lower =  cast$lower[,2],
upper =  cast$upper[,2],
total = d[d$date > as.Date("2017-3-31") & d$date <= as.Date("2017-3-31")+ 30, "suicide"],
date  = d[d$date > as.Date("2017-3-31") & d$date <= as.Date("2017-3-31")+ 30,"date"])

ddd$eff <- ((ddd$total - ddd$mean)/ddd$mean)*100
ddd$Hi  <- ((ddd$total - ddd$lower)/abs(ddd$lower))*100
ddd$Lo  <- ((ddd$total - ddd$upper)/abs(ddd$upper))*100




a<-0.2
blue 	<-rgb(79, 120, 165, 255*a, max=255)

plot(date,1:length(date), type = "n", pch= 19,
ylim = c(0,100), cex = 0.6, cex.axis = 0.6, cex.lab = 0.8, cex.main= 0.8, xlab = "", main = "",
ylab = "", tck = 0.01)
title(main = "a", adj =0)
for(i in 2:ncol(d)){
lines(date, d[,i], col = blue)
}

l
