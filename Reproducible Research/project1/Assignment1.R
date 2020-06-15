library(Hmisc)
library(data.table)
library(ggplot2)
path = getwd()

#Download the zip file and extracts it into the working directory.
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(url, file.path(path, "Dataset.zip"))
unzip(zipfile = "Dataset.zip")

#Loading and processing data as table and converting time from character to class date 
dataset <- data.table::fread("activity.csv")
dataset$date <- as.POSIXct(dataset$date, "%Y-%m-%d")
weekday <- weekdays(dataset$date)
dataset <- cbind(dataset,weekday)
summary(dataset)

#Histogram number of steps per day.
tsteps <- aggregate(steps ~ date, data = dataset, FUN = sum, na.rm = TRUE)
head(tsteps)
hist(tsteps$steps, xlab = "Number of Steps", main = "Total Number of Steps"
     , col = "red")
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()

#Mean and Median and total number of the steps. 
stepsmean <- mean(tsteps$steps)
stepsmean
stepsmedian <- median(tsteps$steps)
stepsmedian


#Time series plot of average number of steps taken.
stepsTime <- aggregate(steps ~ interval, data = dataset, FUN = mean, na.rm = TRUE)
plot(steps~interval, data=stepsTime, type="l", xlab = "Interval", ylab = "Steps"
     , main = "Average Number of Steps", col = "red")
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()

#The 5-minute interval that, on average, contains the maximum number of steps.
maxsteps <- max(stepsTime$steps)
stepsTime[stepsTime$steps == maxsteps,]

#Imputing NA values.
sum(is.na(dataset))
dataset$steps <- with(dataset,impute(steps, mean))

#Histogram number of steps per day after imputation.
tsteps <- aggregate(steps ~ date, data = dataset, FUN = sum)
hist(tsteps$steps, xlab = "Number of Steps", main = "Total Number of Steps"
     , breaks = 30, col = "red")
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()

#Panel plot comparing the average number of steps taken per 5-minute interval 
#across weekdays and weekends
dataset$datetype <- sapply(dataset$date, function(x) {
        if (weekdays(x) == "Sunday" | weekdays(x) =="Saturday"){y <- "Weekend"}
        else{y <- "Weekday"}
        y})

stepsdatetype <- aggregate(steps ~ interval + datetype, dataset, mean, na.rm = TRUE)
gplot<- ggplot(stepsdatetype, aes(x = interval , y = steps, color = datetype)) +
        geom_line(stat = "identity") +
        labs(title = "Average Daily Steps by Type of date", x = "Interval", 
             y = "Average number of Steps") +facet_grid(datetype~.)
gplot

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()

