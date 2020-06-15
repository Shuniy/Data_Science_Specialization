library(data.table)
path = getwd()

#Download the zip file and extracts it into the working directory.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "Dataset.zip"))
unzip(zipfile = "Dataset.zip")

#Reading data from the file
data <- data.table::fread(file.path(path,"household_power_consumption.txt"), na.strings = "?",stringsAsFactors = FALSE)

#Converting character data in Data column to class Date.
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Selecting data from specific dates.
data <- data[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Creating Histogram with red color with title and x and y lables.
hist(data$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#Creating a png file of the plotted histogram.
dev.copy(png,file = "plot1.png", height = 480, width = 480)

dev.off()


