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

## save plot 3 to git repo folder (Global Active Power usage over time)
png(filename = paste0(gitrepo, "plot3.png"), width = 480, height = 480 )

plot(data$DateTime, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", cex.lab = 0.9, cex.axis = 0.9)
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"), cex = 0.9)

dev.off()
