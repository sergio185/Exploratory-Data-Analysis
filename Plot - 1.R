## Dataset from https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

library(lubridate)

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

power_consumption$Date <- dmy(power_consumption$Date)

power_consumption_2_days <- subset(power_consumption
                                   , Date >= ymd('2007-02-01') &
                                       Date <= ymd('2007-02-02')
                                   )

png(filename = 'plot1.png')

with(power_consumption_2_days
     , hist(Global_active_power, main = 'Global Active Power'
            , xlab = 'Global Active Power (kilowatts)', col = 'red'
            )
     )

dev.off()
