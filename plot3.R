#3. Of the four types of sources indicated by the type (point, nonpoint,
#onroad, nonroad) variable, which of these four sources have seen
#decreases in emissions from 1999–2008 for Baltimore City? Which have seen
#increases in emissions from 1999–2008? Use the ggplot2 plotting system
#to make a plot answer this question.

#set the working directory to be the Course Project folder
setwd("~/Desktop/Online/OWinter Term 2014/Exploratory Data Analysis/Course Projects/Course Project 2")

#install and load the ggplot2 package
#install.packages("ggplot2")
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

#class(NEI) # => data.frame
#class(SCC) # => data.frame
#class(NEI$year) # => "integer"
#class(NEI$type) # => "character"

#consider only the Baltimore City data from the NEI data frame
baltimore <- NEI[(NEI$fips=="24510"), ]

#turn the type variables into lowercase and replace the "-" with ""
baltimore$type <- tolower(baltimore$type)
baltimore$type <- gsub("-", "", baltimore$type)

#initialize the years, emissions and type vectors to make data frames
years <- rep(c(1999, 2002, 2005, 2008), 4)
emissions <- rep(c(0, 0, 0, 0), 4)

types <- levels(as.factor(baltimore$type))
#class(types) # => "character"
type <- rep(types, 1, each=4)

result <- data.frame(type, years, emissions)

for(idx in seq(result$type)) {
        #print(idx)
        currentType <- result[idx, 1]
        currentYear <- result[idx, 2]
        data <- baltimore[(baltimore$year==currentYear & baltimore$type==currentType),]
        result[idx, 3] <- sum(data$Emissions)
}

qplot(years, log(emissions), data=result, facets=.~type, geom=c("line"),
      xlab="Years", ylab="Log of Amount of PM2.5 emitted (in tons)",
      main="Trend in total emissions of PM2.5 across four types of sources\n in Baltimore City, Maryland from 1999 to 2008")

dev.copy(png, file="plot3.png")
dev.off()


