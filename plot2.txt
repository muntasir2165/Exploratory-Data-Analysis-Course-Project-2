#2. Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system
#to make a plot answering this question.

#set the working directory to be the Course Project folder
setwd("~/Desktop/Online/OWinter Term 2014/Exploratory Data Analysis/Course Projects/Course Project 2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

#class(NEI) # => data.frame
#class(SCC) # => data.frame
#class(NEI$year) # => "integer"

#consider only the Baltimore City data from the NEI data frame
baltimore <- NEI[(NEI$fips=="24510"), ]

#initialize the years and emissions vectors to make a data frame
years <- c(1999, 2002, 2005, 2008)
emissions <- c(0, 0, 0, 0)

totalEmission <- data.frame(years, emissions)

#determine the total emissions for each of the 4 years and input it into
#the totalEmission data frame
for (i in seq(years)) {
        print(i)
        data <- baltimore[(baltimore$year==years[i]), ]
        totalEmission[i, 2] <- sum(data$Emissions)
}

#set the margin
par(mar=c(5,4,4,1))

plot(totalEmission$years, totalEmission$emissions, type="o",
     xlab="Years", ylab="Amount of PM2.5 emitted (in tons)",
     main="Trend in total emissions of PM2.5 in\n Baltimore City, Maryland\n from 1999 to 2008",
     col="Purple")

dev.copy(png, file="plot2.png")
dev.off()
