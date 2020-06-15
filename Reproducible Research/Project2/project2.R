library(data.table)
library(ggplot2)
library(gridExtra)
library(grid)
library(R.utils)

path <- getwd()

#Downloads and read data from zip file provided through url.
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
stormdata <- data.table::fread(url)
#Column names  and some values of the table.
names(stormdata)
head(stormdata)

#Collecting only required column stormdata.
stormdata <- stormdata[,c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP"
                     , "CROPDMG", "CROPDMGEXP")]

#Checking for distint values.
unique(stormdata$PROPDMGEXP)
unique(stormdata$CROPDMGEXP)

#Changing the values to user readable values. 
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "K"] <- 1000
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "M"] <- 1e+06
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == ""] <- 1
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "B"] <- 1e+09
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "m"] <- 1e+06
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "0"] <- 1
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "5"] <- 1e+05
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "6"] <- 1e+06
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "4"] <- 10000
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "2"] <- 100
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "3"] <- 1000
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "h"] <- 100
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "7"] <- 1e+07
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "H"] <- 100
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "1"] <- 10
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "8"] <- 1e+08

# Assigning '0' to invalid exponent stormdata
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "+"] <- 0
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "-"] <- 0
stormdata$PROPDMGEXP[stormdata$PROPDMGEXP == "?"] <- 0

#Changing class of PROPDMGEXP to numeric.
stormdata$PROPDMGEXP <- as.numeric(stormdata$PROPDMGEXP)

# Assigning values for the crop exponent stormdata 
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == "M"] <- 1e+06
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == "K"] <- 1000
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == "m"] <- 1e+06
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == "B"] <- 1e+09
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == "0"] <- 1
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == "k"] <- 1000
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == "2"] <- 100
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == ""] <- 1

# Assigning '0' to invalid exponent stormdata
stormdata$CROPDMGEXP[stormdata$CROPDMGEXP == "?"] <- 0

#Changing class of CROPDMGEXP to numeric.
stormdata$CROPDMGEXP <- as.numeric(stormdata$CROPDMGEXP)

# Calculating the property damage value
stormdata$PROPDMGVAL <- stormdata$PROPDMG * stormdata$PROPDMGEXP

# calculating the crop damage value
stormdata$CROPDMGVAL <- stormdata$CROPDMG * stormdata$CROPDMGEXP

#Totalling numbers by events and selecting data with values greater than 0.
FatalitiesData <- aggregate(FATALITIES ~ EVTYPE, stormdata, FUN = sum, na.rm = TRUE)
FatalitiesData <- FatalitiesData[FatalitiesData$FATALITIES > 0,]

InjuriesData <- aggregate(INJURIES ~ EVTYPE, stormdata, FUN = sum, na.rm = TRUE)
InjuriesData <- InjuriesData[InjuriesData$INJURIES > 0,]

PropDmgValueData <- aggregate(PROPDMGVAL ~ EVTYPE, stormdata, FUN = sum, na.rm = TRUE)
PropDmgValueData <- PropDmgValueData[PropDmgValueData$PROPDMGVAL > 0,]

CropDmgValueData <- aggregate(CROPDMGVAL ~ EVTYPE, stormdata, FUN = sum, na.rm = TRUE)
CropDmgValueData <- CropDmgValueData[CropDmgValueData$CROPDMGVAL > 0,]

#Ordering events with highest fatalities.
FatalitiesData <- FatalitiesData[order(-FatalitiesData$FATALITIES), ]
head(FatalitiesData)

#Ordering events with highest injuries.
InjuriesData <- InjuriesData[order(-InjuriesData$INJURIES), ]
head(InjuriesData)

#Ordering events with highest Property Damage.
PropDmgValueData <- PropDmgValueData[order(-PropDmgValueData$PROPDMGVAL), ]
head(PropDmgValueData)

#Ordering events with highest injuries.
CropDmgValueData <- CropDmgValueData[order(-CropDmgValueData$CROPDMGVAL), ]
head(CropDmgValueData)

#Plotting events with highest Fatalities
plot1 <- ggplot(data = FatalitiesData[1:10,], aes(x = reorder(EVTYPE, FATALITIES), 
                          y = FATALITIES/1000, color = EVTYPE, fill = EVTYPE)) +
        geom_bar(stat = "identity")  + coord_flip() + 
        ylab("Total number of Fatalities in Thousands") + xlab("Event type") +
        ggtitle("Fatalities in US by Top 10 Events")

#Plotting events with highest Injuries
plot2 <- ggplot(data = InjuriesData[1:10,], aes(x = reorder(EVTYPE, INJURIES),
                            y = INJURIES/1000, color = EVTYPE, fill = EVTYPE)) +
        geom_bar(stat = "identity") + coord_flip() +
        ylab("Total number of Injuries in Thousands") + xlab("Event type") +
        ggtitle("Injuries in US by Top 10 Events")

#Combining them to make 1 Plot
grid.arrange(plot1, plot2, nrow =2)

#Plotting events with highest Property Damage.
plot3 <- ggplot(data = PropDmgValueData[1:10,], aes(x = reorder(EVTYPE, PROPDMGVAL), 
                         y = PROPDMGVAL/1000000, color = EVTYPE, fill = EVTYPE)) +
        geom_bar(stat = "identity")  + coord_flip() + 
        ylab("Total Damage to Property in  Million") + xlab("Event type") +
        ggtitle("Property Damage in US by Top 10 Events")

#Plotting events with highest Crop Damage.
plot4 <- ggplot(data = CropDmgValueData[1:10,], aes(x = reorder(EVTYPE, CROPDMGVAL), 
                         y = CROPDMGVAL/1000000, color = EVTYPE, fill = EVTYPE)) +
        geom_bar(stat = "identity")  + coord_flip() + 
        ylab("Total Damage to Crop in Million") + xlab("Event type") +
        ggtitle("Crop Damage in US by Top 10 Events")

#Combining them to make 1 plot.
grid.arrange(plot3, plot4, nrow =2)
