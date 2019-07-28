# Load libraries
library(dplyr)
library(lubridate)

# Set locale to "C" (reflects North-American usage) for category "LC_TIME" which
# controls rendering of month names in plots
Sys.setlocale(category = "LC_TIME", locale = "C")

# Clear environment
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
png('plot4.png')
par(mfrow = c(2, 2))
with(df2007, {
  # Plot date_time vs. global active power
  plot(date_time, global_active_power, 
       xlab = '', 
       ylab = 'Global Active Power',
       type = 'n')
  lines(date_time, global_active_power)
  
  # Plot date_time vs. voltage
  plot(date_time, voltage, 
       xlab = 'datetime', 
       ylab = 'Voltage', 
       type = 'n')
  lines(date_time, voltage)
  
  # Plot date_time vs. sub metering 1-3
  plot(date_time, sub_metering_1, 
       xlab = "",
       ylab = 'Energy sub metering ', 
       type = 'n')
  lines(date_time, sub_metering_1)
  lines(date_time, sub_metering_2, col = 'red')
  lines(date_time, sub_metering_3, col = 'blue')
  legend('topright', 
         legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
         col = c('black', 'red', 'blue'), 
         lty = 1, 
         bty = 'n')
  
  # Plot date_time vs global reactive power
  plot(date_time, global_reactive_power, 
       xlab = 'datetime', 
       ylab = 'Global_reactive_power', 
       type = 'n')
  lines(date_time, global_reactive_power)
})
dev.off()
