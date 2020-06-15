---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md : TRUE
---

```r
knitr::opts_chunk$set(message = FALSE,warning=FALSE,echo = TRUE)
```



## Loading and preprocessing the data


```r
library(Hmisc)
library(data.table)
library(ggplot2)
path = getwd()
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(url, file.path(path, "Dataset.zip"))
unzip(zipfile = "Dataset.zip")
dataset <- data.table::fread("activity.csv")
dataset$date <- as.POSIXct(dataset$date, "%Y-%m-%d")
weekday <- weekdays(dataset$date)
dataset <- cbind(dataset,weekday)
```

```r
summary(dataset)
```

```
##      steps             date               interval        weekday         
##  Min.   :  0.00   Min.   :2012-10-01   Min.   :   0.0   Length:17568      
##  1st Qu.:  0.00   1st Qu.:2012-10-16   1st Qu.: 588.8   Class :character  
##  Median :  0.00   Median :2012-10-31   Median :1177.5   Mode  :character  
##  Mean   : 37.38   Mean   :2012-10-31   Mean   :1177.5                     
##  3rd Qu.: 12.00   3rd Qu.:2012-11-15   3rd Qu.:1766.2                     
##  Max.   :806.00   Max.   :2012-11-30   Max.   :2355.0                     
##  NA's   :2304
```



## What is mean total number of steps taken per day?
1.Calculate the total number of steps taken per day


```r
tsteps <- aggregate(steps ~ date, data = dataset, FUN = sum, na.rm = TRUE)
```

```r
head(tsteps)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```



2.If you do not understand the difference between a histogram and a barplot, research the difference between them. Make a histogram of the total number of steps taken each day


```r
hist(tsteps$steps,xlab ="Number of Steps",main="Total Number of Steps",col="red")
```

![](PA1_template_files/figure-html/plot1-1.png)<!-- -->



3.Calculate and report the mean and median of the total number of steps taken per day.


```r
stepsmean <- mean(tsteps$steps)
stepsmean
```

```
## [1] 10766.19
```

```r
stepsmedian <- median(tsteps$steps)
stepsmedian
```

```
## [1] 10765
```




## What is the average daily activity pattern?



1.Make a time series plot (i.e. \color{red}{\verb|type = "l"|}type="l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
stepsTime <- aggregate(steps ~ interval,data = dataset,FUN = mean,na.rm = TRUE)
```

```r
plot(steps~interval,data=stepsTime,type="l",xlab ="Interval",ylab = "Steps",main ="Average Number of Steps",col = "red")
```

![](PA1_template_files/figure-html/plot2-1.png)<!-- -->



2.Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?


```r
maxsteps <- max(stepsTime$steps)
stepsTime[stepsTime$steps == maxsteps,]
```

```
##     interval    steps
## 104      835 206.1698
```



## Imputing missing values



1.Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with \color{red}{\verb|NA|}NAs)


```r
sum(is.na(dataset))
```

```
## [1] 2304
```



2.Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

###Filling missing values with the use of Hmisc package and function impute.

```r
dataset$steps <- with(dataset,impute(steps, mean))
```



3.Create a new dataset that is equal to the original dataset but with the missing data filled in.

```r
dataset$steps <- with(dataset,impute(steps, mean))
```



4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?


```r
tsteps <- aggregate(steps ~ date, data = dataset, FUN = sum)
hist(tsteps$steps,xlab ="Number of Steps",main ="Total Number of Steps",breaks=30,col ="red")
```

![](PA1_template_files/figure-html/plot3-1.png)<!-- -->



## Are there differences in activity patterns between weekdays and weekends?
1.Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.


```r
dataset$datetype <- sapply(dataset$date, function(x) {
        if (weekdays(x) == "Sunday" | weekdays(x) =="Saturday"){y <- "Weekend"}
        else{y <- "Weekday"}
        y})
```



2.Make a panel plot containing a time series plot (i.e. \color{red}{\verb|type = "l"|}type="l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.



```r
stepsdatetype <- aggregate(steps ~ interval + datetype, dataset, mean, na.rm = TRUE)
```

```r
gplot<- ggplot(stepsdatetype,aes(x =interval,y =steps,color=datetype)) +       geom_line(stat = "identity") + labs(title = "Average Daily Steps by Type of date",x ="Interval", y ="Average number of Steps") +facet_grid(datetype~.)
gplot
```

![](PA1_template_files/figure-html/plot4-1.png)<!-- -->
