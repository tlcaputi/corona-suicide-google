library("gtrendR")
ROOTPATH <- "C:/Users/tcapu/Google Drive/PublicHealthStudies/coronasuicide"
setwd(ROOTPATH)

files <- dir("C:/Users/tcapu/Google Drive/modules/gtrendR/R", ".R", full.names = T)
for(f in files) source(f)


int <- ymd("2020-03-13")
beg <- ymd("2020-01-15")

multiterms_day <- multi_term_arima(

  ## A folder containing all of your gtrends data
  input_dir = "./input/individual",

  ## Which data to use
  geo = "US", # Geography you want to use
  terms_to_use = NA, # Terms you'd like to analyze. If NA then all terms
  timeframe_to_use = "day", # Only analyze data with filenames that contain a certain timeframe. If NA then all timeframes


  ## Parameters of time periods
  beginperiod = beg, # Beginning of the before period, if T then beginning of data
  endperiod = T, # End of the end period, if T then end of data
  interrupt = int, # Date for interruption, splitting before and after periods


  ## Analytical arguments
  bootstrap = T, # Bootstrap CIs
  bootnum = 1000, # Number of bootstraps
  kalman = T # If T, impute with Kalman
)

 
multiterms_week <- multi_term_arima(

  ## A folder containing all of your gtrends data
  input_dir = "./input/individual",

  ## Which data to use
  geo = "US", # Geography you want to use
  terms_to_use = NA, # Terms you'd like to analyze. If NA then all terms
  timeframe_to_use = "week", # Only analyze data with filenames that contain a certain timeframe. If NA then all timeframes


  ## Parameters of time periods
  beginperiod = beg, # Beginning of the before period, if T then beginning of data
  endperiod = T, # End of the end period, if T then end of data
  interrupt = int, # Date for interruption, splitting before and after periods


  ## Analytical arguments
  bootstrap = T, # Bootstrap CIs
  bootnum = 1000, # Number of bootstraps
  kalman = T # If T, impute with Kalman
)


US_df <- run_arima(
  df = read.csv("./input/suicide_day.csv", header = T, stringsAsFactor = F), # Data from gtrends
  begin = beg,
  end = T,
  interrupt = int, # Interruption point in your data
  geo = "US", # geography you want to use
  kalman = T, # If True, uses Kalman method to impute time series
  rsv = F
)


save(multiterms_day,  file = "./temp/multiterms_day.RData")
save(multiterms_week, file = "./temp/multiterms_week.RData")
save(US_df, file = "./temp/US_df.RData")
