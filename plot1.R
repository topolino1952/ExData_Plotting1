# Load library
library(dplyr)

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


# Create and save plot 1 using the Base system

png('plot1.png')
hist(df2007$global_active_power, 
     col = 'red', 
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency', 
     main = 'Global Active Power')
dev.off()
