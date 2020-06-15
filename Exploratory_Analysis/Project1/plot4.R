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
par(mfrow=c(2,2))

# Ploting graph 1
plot(data$dateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## Ploting graph 2
plot(data$dateTime,data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Ploting graph 3
plot(data$dateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$dateTime, data$Sub_metering_2, col="red")
lines(data$dateTime, data$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), bty="n", cex=.5) 

# Ploting graph 4
plot(data$dateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#Creating a png file of the plotted graph.
dev.copy(png,file = "plot4.png", height = 480, width = 480)
dev.off()