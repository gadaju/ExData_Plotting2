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
png(file = "plot6.png",width = 480,height = 480) 

# 6.) Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

plot6_data <- select(bd, Emissions, year, EI.Sector, fips) %>%
  filter(grepl("Mobile - On-Road",EI.Sector), grepl("24510|06037",fips)) %>%
  group_by(year,fips) %>%
  summarize(totalPM25= sum(Emissions))

ggplot(data=plot6_data, aes(x=year, y=totalPM25, group = fips, colour = fips)) +
  geom_line() +
  geom_point( size=4, shape=21, fill="white")


## Close the PNG file device
dev.off() 
## Now you can view the file 'myplot.png' on your computer
