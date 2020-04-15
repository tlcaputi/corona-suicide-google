library("gtrendR")
ROOTPATH <- "C:/Users/tcapu/Google Drive/PublicHealthStudies/coronasuicide"
setwd(ROOTPATH)

# files <- dir("C:/Users/tcapu/Google Drive/modules/gtrendR/R", ".R", full.names = T)
# for(f in files) source(f)

load("./temp/multiterms_day.RData")
load("./temp/multiterms_week.RData")
load("./temp/US_df.RData")

int <- ymd("2020-03-13")
beg <- ymd("2020-01-15")
multiterms <- multiterms_day

panA <- multiterm_barplot(
  multiterm_list = multiterms[[1]] %>% filter(hi95 > mean),

  ## Graphing Parameters
  title = NULL, # If NULL, no Title
  xlab = NULL, # x axis label
  label_df = NA, # Use a two-column dataframe to label the barplot x axis
  ylab = "Greater than Expected (%)", # y axis label
  space = 0.8, # space between bars
  barlabel = F,

  ## Set a colorscheme
  colorscheme = "blue",  # Color schemes set in this package "red", 'blue" or "jamaim"

  # ... customize any color using these
  hicol = NA, # Color of bars

  ## Saving arguments
  save = T, # If T, save plot
  outfn = './output/panA.png', # Location to save plot
  width = 6, # Width in inches
  height = 3 # Height in inches
)

panA <- panA + theme(axis.text.x = element_text(angle = 75, hjust = 1)) + coord_cartesian(ylim = c(NA, 1.3))



panB <- multiterm_spaghetti(
  multiterm_list = multiterms,
  interrupt = int,
  terms_to_use = NA,
  normalize = T,

  ## Plot Arguments
  beginplot = beg, # Start date for the plot. If T, beginning of data
  endplot = T, # End date for the plot. If T, end of data
  title = NULL, # If NULL, no Title
  xlab = "Date", # x axis label
  lbreak = "3 month", # Space between x-axis tick marks
  xfmt = date_format("%b-%Y"), # Format of dates on x axis
  ylab = "Scaled Search Volumes", # y axis label
  lwd = 1, # Width of the line
  ylim = c(NA, NA), # y axis limts
  vlinecol = "black", # color of vertical line
  vlinelwd = 1, # width of vertical line


  ## Spaghetti specific adjustments
  spaghettialpha = 0.6, # How transparent do you want the spaghetti lines

  ## Set a colorscheme
  colorscheme = "blue",  # Color schemes set in this package "red", 'blue" or "jamaim"

  # ... customize any color using these
  hicol = NA, # Color of US line
  locol = NA, # Color of other lines

  ## Saving arguments
  save = T, # If T, save plot
  outfn = './output/panB.png', # Location to save plot
  width = 6, # Width in inches
  height = 3 # Height in inches
)


panC <- arima_plot(
  US_df, ## data from run_arima

  ## Create a vertical "interruption" line in your plot
  interrupt = int, # Date of an interruption
  linelabel = "",
  linelabelpos = 0.02, # Where the label goes near the interruption line

  ## Plot Arguments
  beginplot = beg, # Start date for the plot. If T, beginning of data
  endplot = "2020-04-11", # End date for the plot. If T, end of data
  title = NULL, # If NULL, no Title
  xlab = "Date", # x axis label
  lbreak = "15 day", # Space between x-axis tick marks
  xfmt = date_format("%b %d"), # Format of dates on x axis
  ylab = "Query Fraction\n(Per 10 Million Searches)", # y axis label
  lwd = 0.6, # Width of the line
  # label = T, # put increase in searches in plot
  # labsize = 0.8, # size of label
  label = F, # put increase in searches in plot
  ylim = c(0, 4000),


  ## Set a colorscheme
  colorscheme = "blue",  # Color schemes set in this package "red", 'blue" or "jamaim"

  # ... customize any color using these
  hicol = NA, # Actual line color
  locol = NA, # Expected line color
  nucol = NA, # Excess polygon color


  ## Saving arguments
  save = T, # If T, save plot
  outfn = './output/panC.png', # Location to save plot
  width = 6, # Width in inches
  height = 3 # Height in inches

)


panD <- arima_ciplot(
  US_df, ## data from run_arima

  ## Create a vertical "interruption" line in your plot
  interrupt = int, # Date of an interruption

  ## Plot Arguments
  beginplot = T, # Start date for the plot. If T, beginning of data
  endplot = "2020-04-11", # End date for the plot. If T, end of data
  title = NULL, # If NULL, no Title
  xlab = "Date", # x axis label
  lbreak = "6 day", # Space between x-axis tick marks
  xfmt = date_format("%b %d"), # Format of dates on x axis
  ylab = "Greater than Expected (%)", # y axis label
  lwd = 1, # Width of the line
  vline = F,
  hline = F,


  ## Set a colorscheme
  colorscheme = "blue",  # Color schemes set in this package "red", 'blue" or "jamaim"

  # ... customize any color using these
  hicol = NA, # Actual color
  nucol = NA, # Polygon color


  ## Saving arguments
  save = T, # If T, save plot
  outfn = './output/panD.png', # Location to save plot
  width = 6, # Width in inches
  height = 3, # Height in inches
  extend = F
)

panD <- panD + coord_cartesian(xlim = c(ymd(int) + 1, NA))

rawcounts_df <- get_rawcounts(
  df = US_df, # data from run_arima

  ## Analysis arguments
  interrupt = int, # Beginning of period to calculate raw counts
  endperiod = T, # Default T, estimates will be given until the last available date in the dataset
  geo = "US", # the geography you're interested in

  ## Comscore Arguments
  month = 2, # Default is 2
  pct_desktop = 0.35,

  ## Google Trends API Argument
  qf_denominator = 10000000 # Denominator of query fractions, should be 10M, do not change
)


panC <- panC + theme(legend.position = "none")
s1 <- seq.Date(beg, ymd("2020-04-18"), by = "15 day")
panC <- panC + scale_x_date(
    lim = c(min(s1), max(s1)),
    breaks = s1, labels = function(x) ifelse(as.numeric(x - beg) %% 1 != 0, "", format(x, format = "%b %d"))
  )

s2 <- seq.Date(ymd(int), ymd("2020-04-12"), by = "6 day")
panD <- panD + scale_x_date(
    lim = c(min(s2), max(s2)),
    breaks = s2, labels = function(x) ifelse(as.numeric(x - beg) %% 1 != 0, "", format(x, format = "%b %d"))
  )

row1 <- plot_grid(panC, panD, labels = c("A", "B"), ncol = 2)
row2 <- plot_grid(panA, labels = c("C"), ncol = 1)
fig <- plot_grid(row1, row2, ncol = 1, rel_heights = c(0.4,0.6))
save_plot("./output/Fig.pdf", fig, base_width = 9, base_height = 8)
save_plot("./output/Fig.png", fig, base_width = 9, base_height = 8)
