library(data.table)
library(ggplot2)

path = getwd()

#Download the zip file and extracts it into the working directory.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "Dataset.zip"))
unzip(zipfile = "Dataset.zip")

#Reading Files from working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Creating a new data frame with two variables year and 
#emissions = total emmision in an year in Baltimore City.
totalemmission <- subset(NEI, fips == "24510")

#plotting Graph using ggplot2
gplot <- ggplot(data = totalemmission, aes(factor(year), Emissions, Fill = type)) + facet_grid(.~type) + geom_bar(stat = "identity") + xlab("Years") + ylab("Total PM(2.5) Emission in Tons") + ggtitle("Emission in Baltimore City by various source types")
print(gplot)

#Exporting image in PNG format.
dev.copy(png,file = "plot3.png", height = 480, width = 480)

dev.off()
