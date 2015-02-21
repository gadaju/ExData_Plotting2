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
png(file = "plot5.png",width = 480,height = 480) 

# 5.) How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

plot5_data <- select(bd, Emissions,year,EI.Sector,fips) %>%
  filter(grepl("Mobile - On-Road",EI.Sector), fips =="24510" ) %>%
  group_by(year) %>%
  summarize(totalPM25= sum(Emissions))

library(ggplot2)

## Setup ggplot with data frame
ggplot(plot5_data, aes(year,totalPM25)) + 
  geom_line(color="red") +
  theme_bw(base_family = "Avenir", base_size = 10) +
  labs(x = "Year") +
  labs(y = "Tons of PM2.5") +
  labs(title = "Emissions from Motor Vehicle Sources")

## Close the PNG file device
dev.off() 
## Now you can view the file 'myplot.png' on your computer
