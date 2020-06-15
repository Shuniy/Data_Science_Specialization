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

#Searching EI Sector column with Coal combution sources
coalcombution <- grep("Fuel Comb.*Coal", SCC$EI.Sector)
coalsources <- SCC[coalcombution,]

coalemission <- subset(NEI, NEI$SCC %in% coalsources$SCC)

#Plotting grapg using ggplot2
gplot <- ggplot(coalemission, aes(factor(year),Emissions/1000, fill = year)) +geom_bar(stat = "identity") + xlab("Years") + ylab("Total PM(2.5) Emission in Tons") + ggtitle("Emission in United States by Coal Combution")
print(gplot)

#Exporting image in PNG format.
dev.copy(png,file = "plot4.png", height = 480, width = 480)

dev.off()
