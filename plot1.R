#1. Have total emissions from PM2.5 decreased in the United States from
#1999 to 2008? Using the base plotting system, make a plot showing the
#total PM2.5 emission from all sources for each of the years 1999, 2002,
#2005, and 2008.

#set the working directory to be the Course Project folder
setwd("~/Desktop/Online/OWinter Term 2014/Exploratory Data Analysis/Course Projects/Course Project 2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

#class(NEI) # => data.frame
#class(SCC) # => data.frame

#class(NEI$SCC) # => "character
#class(NEI$Emissions) # => "integer
#class(NEI$year) # => "integer"

#initialize the years and emissions vectors to make a data frame
years <- c(1999, 2002, 2005, 2008)
emissions <- c(0, 0, 0, 0)

totalEmission <- data.frame(years, emissions)

#determine the total emissions for each of the 4 years and input it into
#the totalEmission data frame
for (i in seq(years)) {
        print(i)
        data <- NEI[(NEI$year==years[i]), ]
        totalEmission[i, 2] <- sum(data$Emissions)
}

#set the margin
par(mar=c(5,4,4,1))

plot(totalEmission$years, totalEmission$emissions, type="o",
     xlab="Years", ylab="Amount of PM2.5 emitted (in tons)",
     main="Trend in total emissions of PM2.5\n in the United States across\n all sources from 1999 to 2008",
     col="Blue")

dev.copy(png, file="plot1.png")
dev.off()

#========================================================================#
# #make a character vector with one instance of each of the different sources
# sources <- levels(as.factor(NEI$SCC))
# #class(sources) # => "character"
# #length(sources) # => 5386
# 
# #make four data frames with sources and emissions columns for each of the 4 
# #years: 1999, 2002, 2005, and 2008
# 
# #first initialize an emissions column with zeroes
# emissions <- vector(mode="numeric", len=length(sources))
# 
# data1999 <- data.frame(sources, emissions)
# #names(data1999) <- names("sources", "emissions")
# data2002 <- data.frame(sources, emissions)
# #names(data2002) <- names("sources", "emissions")
# data2005 <- data.frame(sources, emissions)
# #names(data2005) <- names("sources", "emissions")
# data2008 <- data.frame(sources, emissions)
# #names(data2008) <- names("sources", "emissions")
# 
# #counter variable
# i <- 0 
# #populate the four data frames with the emissions data from the four
# #different years across all the sources
# for (current_source in sources) {
#         i <- i+1
#         print(i)
#         #print(current_source)
#         for (year in c(1999, 2002, 2005, 2008)) {
#                 data <- NEI[(NEI$SCC==current_source && NEI$year==year), ]
#                 #print(year)
#                 #print(paste("data$year: ", data$year))
#                 #print(paste("data$Emissions: ", data$Emissions))
#                 #print(paste("sum(data$Emissions: ", sum(data$Emissions)))
#                 #print(" ")
#                 
#                 #if there is not record in NEI with current_source in 
#                 #NEI$SCC and year in NEI$year, then skip to the next
#                 #iteration of the for loop
#                 if (nrow(data) == 0) {
#                         next
#                 }
#                 
#                 #if, otherwise, we do have a record in NEI with 
#                 #current_source and year exists, get the total emmission
#                 #and put it in the respective year's data frame
#                 if (year==1999) {
#                         data1999[data1999$sources==current_source, 2] <- sum(data$Emissions)
#                 }
#                 else if (year==2002) {
#                         data2002[data2002$sources==current_source, 2] <- sum(data$Emissions)
#                 }
#                 else if (year==2005) {
#                         data2005[data2005$sources==current_source, 2] <- sum(data$Emissions)
#                 }
#                 else if (year==2008) {
#                         data2008[data2008$sources==current_source, 2] <- sum(data$Emissions)
#                 }
#         }
# }




