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

## save plot 2 to git repo folder (Global Active Power usage over time)
png(filename = paste0(gitrepo, "plot2.png"), width = 480, height = 480 )
plot(data$DateTime, data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)", cex.lab = 0.9, cex.axis = 0.9)
lines(data$DateTime, data$Global_active_power)
dev.off()


