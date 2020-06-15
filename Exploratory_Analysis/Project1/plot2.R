library(data.table)
path = getwd()

#Download the zip file and extracts it into the working directory.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "Dataset.zip"))
unzip(zipfile = "Dataset.zip")

#Reading data from the file
data <- data.table::fread(file.path(path,"household_power_consumption.txt"), na.strings = "?",stringsAsFactors = FALSE)

# Making a POSIXct date capable of being filtered and graphed by time of day
data$dateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

#Selecting data from specific dates.
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

## Ploting graph 
plot(x = data$dateTime, y = data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Creating a png file of the plotted graph.
dev.copy(png,file = "plot2.png", height = 480, width = 480)
dev.off()