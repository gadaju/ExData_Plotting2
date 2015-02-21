library(dplyr)
library(lubridate)

setwd("C:/Users/Gabriel/Documents/Coursera/4 exploratory data analysis/week3/exdata-data-NEI_data/")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# bd = Big Data
bd <- inner_join(SCC, NEI, by = c("SCC" = "SCC"))


# Create plot and send to a file (no plot appears on screen)
setwd("C:/Users/Gabriel/Documents/GitHub/ExData_Plotting2/")

## Open png device; create 'myplot.png' in my working directory
png(file = "plot2.png",width = 480,height = 480) 

# 2.) Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

plot2_data <- select(bd, Emissions,year, fips) %>%
  filter(fips =="24510") %>%
  group_by(year) %>%
  summarize(totalPM25= sum(Emissions))

plot(plot2_data$year,plot2_data$totalPM25,type ='l',
     xlab= 'year', 
     ylab = 'PM2.5 Emissions (tons)')
title(main = "Total PM2.5 Emissions in Baltimore City, Maryland by Year")

## Close the PNG file device
dev.off() 
## Now you can view the file 'myplot.png' on your computer
