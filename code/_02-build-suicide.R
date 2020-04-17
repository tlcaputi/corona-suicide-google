library("gtrendR")
ROOTPATH <- "C:/Users/tcapu/Google Drive/PublicHealthStudies/coronasuicide"
setwd(ROOTPATH)

files <- dir("C:/Users/tcapu/Google Drive/modules/gtrendR/R", ".R", full.name = T)
for(f in files) source(f)


files <- dir("./input/individual", ".csv", full.names = T)
files <- grep("day", files, value = T)
for(f in files){
  df <- read.csv(f, header = T, stringsAsFactor = F)

  proptable <- prop.table(table(is.na(df$US)))
  pct_missing <- proptable[2]
  pct_missing <- ifelse(is.na(pct_missing), 0, pct_missing)

  cat(sprintf("%s: %s", basename(f), pct_missing))
  cat("\n")
}


beg <- ymd("2020-01-15")
int <- ymd("2020-03-13")



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
  na = "kalman", # If T, impute with Kalman

  scale = T,
  logit = T,
  min0  = F
)



US_df <- run_arima(
  df = read.csv("./input/suicide_day.csv", header = T, stringsAsFactor = F), # Data from gtrends
  begin = beg,
  end = T,
  interrupt = int, # Interruption point in your data
  geo = "US", # geography you want to use
  kalman = T, # If True, uses Kalman method to impute time series
  rsv = F,
  periods = c("week")
)


save(multiterms_day,  file = "./temp/multiterms_day.RData")
save(US_df, file = "./temp/US_df.RData")






# multiterms_day[[1]]
# suic_note_logit <- multiterms_day[[2]] %>% select(timestamp, contains("note")) %>% rename_all(funs(gsub("suicide_note__", "", .)))
# suic_note_logit %>% summarise(mean(actual / fitted, na.rm = T))
# mean(suic_note_logit$actual / suic_note_logit$fitted, na.rm = T)
# with(suic_note_logit %>% filter(timestamp >= ymd("2020-03-13")), mean(actual, na.rm = T) / mean(fitted, na.rm = T))
# mean(suic_note_logit$actual, na.rm = T) / mean(suic_note_logit$fitted, na.rm = T)
#
# multiterms_day <- multi_term_arima(
#
#   ## A folder containing all of your gtrends data
#   input_dir = "./input/individual",
#
#   ## Which data to use
#   geo = "US", # Geography you want to use
#   terms_to_use = c("note"), # Terms you'd like to analyze. If NA then all terms
#   # terms_to_use = NA, # Terms you'd like to analyze. If NA then all terms
#   timeframe_to_use = "day", # Only analyze data with filenames that contain a certain timeframe. If NA then all timeframes
#
#
#   ## Parameters of time periods
#   beginperiod = beg, # Beginning of the before period, if T then beginning of data
#   endperiod = T, # End of the end period, if T then end of data
#   interrupt = int, # Date for interruption, splitting before and after periods
#
#
#   ## Analytical arguments
#   bootstrap = T, # Bootstrap CIs
#   bootnum = 1000, # Number of bootstraps
#   na = "kalman", # If T, impute with Kalman
#
#   scale = F,
#   logit = F,
#   min0  = T,
#   logit_a = 0,
#   logit_b = 100
# )
#
# suic_note_min0 <- multiterms_day[[2]] %>% select(timestamp, contains("note")) %>% rename_all(funs(gsub("suicide_note__", "", .)))




# multiterms_week <- multi_term_arima(
#
#   ## A folder containing all of your gtrends data
#   input_dir = "./input/individual",
#
#   ## Which data to use
#   geo = "US", # Geography you want to use
#   # terms_to_use = c("note"), # Terms you'd like to analyze. If NA then all terms
#   terms_to_use = NA, # Terms you'd like to analyze. If NA then all terms
#   timeframe_to_use = "week", # Only analyze data with filenames that contain a certain timeframe. If NA then all timeframes
#
#
#   ## Parameters of time periods
#   beginperiod = beg, # Beginning of the before period, if T then beginning of data
#   endperiod = T, # End of the end period, if T then end of data
#   interrupt = int, # Date for interruption, splitting before and after periods
#
#
#   ## Analytical arguments
#   bootstrap = T, # Bootstrap CIs
#   bootnum = 1000, # Number of bootstraps
#   na = "kalman", # If T, impute with Kalman
#   logit = F,
#   logit_a = 0,
#   logit_b = 100
# )

# multiterms_day <- multi_term_arima(
#
#   ## A folder containing all of your gtrends data
#   input_dir = "./input/individual",
#
#   ## Which data to use
#   geo = "US", # Geography you want to use
#   terms_to_use = c("note"), # Terms you'd like to analyze. If NA then all terms
#   # terms_to_use = NA, # Terms you'd like to analyze. If NA then all terms
#   timeframe_to_use = "day", # Only analyze data with filenames that contain a certain timeframe. If NA then all timeframes
#
#
#   ## Parameters of time periods
#   beginperiod = beg, # Beginning of the before period, if T then beginning of data
#   endperiod = T, # End of the end period, if T then end of data
#   interrupt = int, # Date for interruption, splitting before and after periods
#
#
#   ## Analytical arguments
#   bootstrap = T, # Bootstrap CIs
#   bootnum = 1000, # Number of bootstraps
#   na = "kalman", # If T, impute with Kalman
#
#   scale = F,
#   logit = F,
#   min0  = F,
#   logit_a = 0,
#   logit_b = 100
# )
#
#
# suic_note_notransform <- multiterms_day[[2]] %>% select(timestamp, contains("note")) %>% rename_all(funs(gsub("suicide_note__", "", .)))

# save(multiterms_week, file = "./temp/multiterms_week.RData")


# rev0 <- function(x, logit_a, logit_b) sapply(x, function(obs) (logit_b - logit_a)*exp(obs)/(1+exp(obs)) + logit_a )
# rev0(x = c(-6.821551, -6.406878, -6.894575, -6.719001, -6.714695, -6.196721, -6.66850), logit_a = 0, logit_b = 1000)

#
# [1] "suicide_note_"
#        actual    fitted      lo80       lo95     hi80     hi95
# 27 -1.6404319 -2.648991 -7.990636  -9.926005 2.771012 5.246267
# 28 -0.5794299 -2.648991 -8.092958 -10.201290 2.839613 5.578939
# 29 -1.3799694 -2.648991 -8.046468 -10.492303 2.811469 5.796236
# 30 -0.6736095 -2.648991 -8.226541 -10.569199 2.971492 5.817700
# 31 -1.0432544 -2.648991 -8.299749 -10.731403 2.978111 5.875077
# 32 -2.6655725 -2.648991 -8.275080 -11.063651 3.101304 6.086821
#        actual     fitted         lo80         lo95      hi80      hi95
# 27 0.16240631 0.06605124 0.0003385040 4.888432e-05 0.9410891 0.9947605
# 28 0.35906378 0.06605124 0.0003055909 3.712102e-05 0.9447793 0.9962376
# 29 0.20101391 0.06605124 0.0003201284 2.774845e-05 0.9432924 0.9969702
# 30 0.33768908 0.06605124 0.0002673885 2.569473e-05 0.9512695 0.9970344
# 31 0.26052254 0.06605124 0.0002485174 2.184749e-05 0.9515754 0.9971993
# 32 0.06503567 0.06605124 0.0002547227 1.567150e-05 0.9569465 0.9977325
