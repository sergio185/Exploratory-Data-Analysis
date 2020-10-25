## Dataset from https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

library(lubridate)
library(dplyr)

## Construct the plot and save it to a PNG file with a width of 480 pixels 
## and a height of 480 pixels.
## We will only be using data from the dates 2007-02-01 and 2007-02-02.

fileUrl = 'https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip'
download.file(url = fileUrl, destfile = 'household_power_consumption.zip')
unzip('household_power_consumption.zip')

power_consumption <- read.table('household_power_consumption.txt'
                                , header = TRUE, sep = ';'
                                , na.strings = '?'
                                , colClasses = c('character', 'character'
                                                 , 'numeric', 'numeric'
                                                 , 'numeric', 'numeric'
                                                 , 'numeric', 'numeric'
                                                 , 'numeric'
                                )
)

power_consumption <- mutate(power_consumption, DateTime = paste(Date, Time))

power_consumption$DateTime <- dmy_hms(power_consumption$DateTime)

power_consumption_2_days <- subset(power_consumption
                                   , DateTime >= ymd('2007-02-01') &
                                       DateTime < ymd('2007-02-03')
)

png(filename = 'plot4.png')
par(mfrow = c(2, 2))

with(power_consumption_2_days
     , plot(DateTime, Global_active_power, type = 'l', xlab = ''
            , ylab = 'Global Active Power'
            ) 
     )

with(power_consumption_2_days
     , plot(DateTime, Voltage, type = 'l', xlab = 'datetime'
            )
     )

with(power_consumption_2_days, {
         plot(DateTime, Sub_metering_1, type = 'l', xlab = ''
              , ylab = 'Energy sub metering')
         lines(DateTime, Sub_metering_2, col = 'red')
         lines(DateTime, Sub_metering_3, col = 'blue')
         legend('topright', cex = 0.6, lty = 1
                , col = c('black', 'red', 'blue')
                , legend = c('Sub_metering_1', 'Sub_metering_2'
                             , 'Sub_metering_3')
                )
         }
     )

with(power_consumption_2_days
     , plot(DateTime, Global_reactive_power, type = 'l'
            , xlab = 'datetime', ylab = 'Global reactive power'
            )
     )

dev.off()
