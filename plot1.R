library(dplyr)
library(lubridate)

setwd("C:/Users/Gabriel/Documents/Coursera/4 exploratory data analysis/week3/exdata-data-NEI_data/")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# bd = Big Data
bd <- inner_join(SCC, NEI, by = c("SCC" = "SCC"))

# Create plot and send to a file (no plot appears on screen)
# 1.) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#  Using the base plotting system, make a plot showing the total PM2.5 emission from 
#  all sources for each of the years 1999, 2002, 2005, and 2008.

plot1_data <- select(bd, Emissions,year) %>%
  group_by(year) %>%
  summarize(totalPM25= sum(Emissions))

setwd("C:/Users/Gabriel/Documents/GitHub/ExData_Plotting2/")

## Open png device; create 'myplot.png' in my working directory
png(file = "plot1.png",width = 480,height = 480) 

plot(plot1_data$year,plot1_data$totalPM25/1000000,type ='l',
     xlab= 'year', 
     ylab = 'PM2.5 Emissions (millions of tons)')
title(main = "Total PM2.5 Emissions in US by Year")

## Close the PNG file device
dev.off() 
## Now you can view the file 'myplot.png' on your computer
