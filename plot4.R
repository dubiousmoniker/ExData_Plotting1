setwd("C:\\Users\\cmoore\\Desktop\\Resources\\R Studio Work\\JH Data Science Courses\\C4 - Exploratory Data Analysis\\c4cp1\\")
gitrepo <- "C:\\Users\\cmoore\\Desktop\\Resources\\GitRepos\\ExData_Plotting1\\"
rm(list=ls())

library(data.table)
library(dplyr)

## download file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")

## unzip to .txt file and read data
rawdata <- tbl_df(read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), 
                 sep = ";",
                 na.strings = "?",
                 stringsAsFactors = FALSE,
                 header = TRUE
                 )) 

## fix date, filter out unneeded days in data
data <- rawdata %>% 
          mutate(Date = as.Date(Date, format = "%d/%m/%Y"))  %>% 
          filter(Date == "2007-02-01" | Date == "2007-02-02")

## create date/time column
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S")


## save plot 4 to git repo folder (four graphs)
png(filename = paste0(gitrepo, "plot4.png"), width = 480, height = 480 )

## adjust margins and number of graphs in plot area
par(mfcol = c(2, 2), mar = c(4, 4, 4, 4))


## plot 1
plot(data$DateTime, data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power",  cex.axis = 0.9)
lines(data$DateTime, data$Global_active_power)

## plot 2
plot(data$DateTime, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering",  cex.axis = 0.9)
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"), cex = 0.8, bty = "n")

## plot 3
plot(data$DateTime, data$Voltage, type = "n", xlab = "datetime", ylab = "Voltage",  cex.axis = 0.8)
lines(data$DateTime, data$Voltage)

## plot 4
plot(data$DateTime, data$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power", cex.axis = 0.8)
lines(data$DateTime, data$Global_reactive_power, lwd = 1)

dev.off()
