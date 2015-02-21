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
png(file = "plot3.png",width = 480,height = 480) 

# 3.) Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

plot3_data <- select(bd, Emissions,year,fips,type) %>%
  filter(fips =="24510") %>%
  group_by(year, type) %>%
  summarize(totalPM25= sum(Emissions))

library(ggplot2)

## Setup ggplot with data frame
ggplot(plot3_data, aes(year,totalPM25)) + 
  geom_line(color="red") + 
  facet_wrap(~type, ncol=1)

## Close the PNG file device
dev.off() 
## Now you can view the file 'myplot.png' on your computer
