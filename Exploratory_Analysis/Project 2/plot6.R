library(data.table)
library(dplyr)

path = getwd()

#Download the zip file and extracts it into the working directory.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "Dataset.zip"))
unzip(zipfile = "Dataset.zip")

#Reading Files from working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- tbl_df(NEI)
SCC <- tbl_df(SCC)

#Searching EI Sector column with Vechile sources
MobileVechile <- grep("vehicle", SCC$EI.Sector, ignore.case = TRUE)
VechileSources <- SCC[MobileVechile,]
Vechileemission <- subset(NEI, NEI$SCC %in% VechileSources$SCC)

#Selecting only Baltimore City and Los Angeles
VechileemissionB <- subset(Vechileemission, fips == "24510")
VechileemissionB$fips <- "Baltimore City"
VechileemissionC <- subset(Vechileemission, fips == "06037")
VechileemissionC$fips <- "Los Angeles"

Both <- rbind(VechileemissionB,VechileemissionC)

#plotting Graph using ggplot2
gplot <- ggplot(Both, aes(x=factor(year), y=Emissions, fill=Year)) + geom_bar(aes(fill=year),stat="identity") + facet_grid(fips ~.) + xlab("Years") + ylab("Total PM(2.5) Emission in Tons") + ggtitle("Emission in Baltimore City and Los Angeles by Motor Vechiles")
print(gplot)
#Exporting image in PNG format.
dev.copy(png,file = "plot6.png", height = 480, width = 480)

dev.off()