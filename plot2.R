# Load libraries
library(dplyr)
library(lubridate)

# Set locale to "C" (reflects North-American usage) for category "LC_TIME" which
# controls rendering of month names in plots
Sys.setlocale(category = "LC_TIME", locale = "C")

# clear environment
remove(list=ls())

# Load data
df <- read.table('./data/household_power_consumption.txt', 
                 header = TRUE, 
                 sep = ';', 
                 na.strings = c('?'))

# Filter data
names(df) <- tolower(names(df))

df$date <- as.Date(df$date, "%d/%m/%Y")
df2007 <- df %>%
  filter(date >= "2007-02-01" & date <= "2007-02-02")


# Create new column with concatenated date and time
df2007$date_time <- paste(df2007$date, df2007$time, sep="_")
df2007$date_time <- ymd_hms(df2007$date_time)


# Create and save plot

png('plot2.png')
with(df2007, {
  plot(date_time, global_active_power, 
       xlab = "",
       ylab = 'Global Active Power (kilowatts)', 
       type = 'n')
  lines(date_time, global_active_power)
})
dev.off()