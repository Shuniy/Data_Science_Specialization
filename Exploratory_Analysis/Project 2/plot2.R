library(data.table)

path = getwd()

#Download the zip file and extracts it into the working directory.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "Dataset.zip"))
unzip(zipfile = "Dataset.zip")

#Reading Files from working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Creating a new data frame with two variables year and 
#emissions = total emmision in an year in Baltimore City,MaryLand.
totalemmission <- aggregate(Emissions ~ year, data = NEI, FUN = sum, subset = (fips == "24510"))

#Creating a Bar Graph which shows decrease in PM(2.5) level.
barplot(height = totalemmission$Emissions/1000, names.arg = totalemmission$year,col = totalemmission$year, xlab = "Years", ylab = "Emissions PM(2.5) in Ktons", main = "Emission over the Years 1999-2008 in Baltimore,MaryLand")

#Exporting image in PNG format.
dev.copy(png,file = "plot2.png", height = 480, width = 480)

dev.off()
