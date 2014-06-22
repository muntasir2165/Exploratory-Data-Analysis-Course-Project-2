#6. Compare emissions from motor vehicle sources in Baltimore City with
#emissions from motor vehicle sources in Los Angeles County, California
#(fips == "06037"). Which city has seen greater changes over time in motor
#vehicle emissions?

#set the working directory to be the Course Project folder
setwd("~/Desktop/Online/OWinter Term 2014/Exploratory Data Analysis/Course Projects/Course Project 2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

#class(NEI) # => data.frame
#class(SCC) # => data.frame
#class(NEI$year) # => "integer"
#class(SCC$Short.Name) # => "factor"

#consider only the Baltimore City data from the NEI data frame
baltimore <- NEI[(NEI$fips=="24510"), ]

#make a vector with records of all the Baltimore City related sources
baltimoreSources <- levels(as.factor(baltimore$SCC))

#initialize the sources vector where we will store all the sources related
#to motor vehicles
sources <- vector(mode="character")

#counter variable
#total <- 0
for (i in seq(SCC$SCC.Level.Two)) {
        sourceID <- as.character(SCC$SCC[i])
        name = as.character(SCC$SCC.Level.Two[i])
        vehicle = grepl("vehicle", tolower(name))
        if (vehicle) {
                #print(sourceID)
                #print(name)
                sources <- append(sources, sourceID)
                #total <- total+1
                #print(total)
        }
}

validSources <- vector(mode="character")

for (baltimore in baltimoreSources) {
        if (baltimore %in% sources) {
                validSources <- append(validSources, baltimore)
        }
}

#initialize the years and emissions vectors to make a data frame
years <- c(1999, 2002, 2005, 2008)
emissions <- c(0, 0, 0, 0)

totalEmission <- data.frame(years, emissions)

#determine the total emissions from motor vehicle sources for
#each of the 4 years and input it into the totalEmission data frame
for (idx in seq(years)) {
        #i <- 0
        subset <- NEI[(NEI$year==years[idx]), ]
        for (sourceID in validSources) {
                i <- i+1
                print(i)
                data <- subset[(subset$SCC==sourceID), ]
                totalEmission[idx, 2] <- totalEmission[idx, 2] + sum(data$Emissions)
        }
}

#========================================================================#
#REPEAT THE ABOVE PROCESS AGAIN FOR LOS ANGELES COUNTY, CALIFORNIA

#consider only the Los Angeles Country data from the NEI data frame
la <- NEI[(NEI$fips=="06037"), ]

#make a vector with records of all the Los Angeles Country related sources
laSources <- levels(as.factor(la$SCC))

validSources1 <- vector(mode="character")

for (la in laSources) {
        if (la %in% sources) {
                validSources1 <- append(validSources1, la)
        }
}

#initialize the years and emissions vectors to make a data frame
years1 <- c(1999, 2002, 2005, 2008)
emissions1 <- c(0, 0, 0, 0)

totalEmission1 <- data.frame(years1, emissions1)

#determine the total emissions from motor vehicle sources for
#each of the 4 years and input it into the totalEmission data frame
for (idx in seq(years1)) {
        j <- 0
        subset <- NEI[(NEI$year==years1[idx]), ]
        for (sourceID in validSources1) {
                j <- j+1
                print(j)
                data1 <- subset[(subset$SCC==sourceID), ]
                totalEmission1[idx, 2] <- totalEmission1[idx, 2] + sum(data1$Emissions)
        }
}

#========================================================================#
#========================================================================#
#========================================================================#

#make a data frame with the overall data for Baltimore and Los Angeles
#for plotting
city <- rep(c("Baltimore", "Los Angeles Country"), each=4)
emissionTotal <- c(totalEmission$emissions, totalEmission1$emissions1)
yearsTotal <- rep(years, 2)

result <- data.frame(city,  yearsTotal, emissionTotal)

qplot(yearsTotal, emissionTotal, data=result, geom=c("line"), color=city,
      xlab="Years", ylab="Amount of PM2.5 emitted (in tons)",
      main="Trend in emissions from motor vehicle\n sources in Baltimore City and Los\n Angeles County from 1999–2008")


dev.copy(png, file="plot6.png")
dev.off()