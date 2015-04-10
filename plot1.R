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

## save plot 1 to git repo folder (histogram of Global Active Power usage by kilowatts)
png(filename = paste0(gitrepo, "plot1.png"), width = 480, height = 480 )
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

