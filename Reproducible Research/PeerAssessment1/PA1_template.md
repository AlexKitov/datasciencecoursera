# Reproducible Research: Peer Assessment 1


## Loading and pre-processing the data

The code checks for the existence of the `activity.csv` in the working directory. If the file does not exist the script checks for `activity.zip` and unzips the file. If the `activity.zip` does not exist the code downloads the .zip file unzips it and reads the data from `activity.csv` If there is a problem with the internet connection `download.file` throws a message `method = "internal"` because the `URL = https`


```r
library(lattice)
library(chron)

fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
destFile <- "activity.zip"
dataFile <- "activity.csv"
if (!file.exists(dataFile)) {
        if (!file.exists(destFile)) {
                download.file (fileURL, destFile, method = "internal")
        }
        unzip(destFile)
}  

data <- read.csv(file = dataFile, header = TRUE)
data$date <- as.Date(data$date, format = "%Y-%m-%d")

data$interval <- sprintf("%04d", data$interval)
data$interval <- as.POSIXct(data$interval, format = "%H%M")

data <- data[, c("date", "interval", "steps")]

head(data, n = 6)
```

```
##         date            interval steps
## 1 2012-10-01 2014-06-12 00:00:00    NA
## 2 2012-10-01 2014-06-12 00:05:00    NA
## 3 2012-10-01 2014-06-12 00:10:00    NA
## 4 2012-10-01 2014-06-12 00:15:00    NA
## 5 2012-10-01 2014-06-12 00:20:00    NA
## 6 2012-10-01 2014-06-12 00:25:00    NA
```

As it can be seen from the data in the interval feature current day is added in front of the time interval. This is internally done by `as.POSIXct`. However it is not a problem since all the graphs and intervals later in the report are presented with nice readable intervals.

## What is mean total number of steps taken per day?

At first the code sums up the number of steps for every day. Consequently the mean and median of this total number of steps per day is calculated in `mean` and `median` variables.


```r
daylytotal <- tapply(data$steps, factor(data$date), sum, na.rm = TRUE)

mean <- mean(daylytotal)

median <- median(daylytotal)

mean 
```

```
## [1] 9354
```

```r
median
```

```
## [1] 10395
```

The `mean` total number of steps per day is **9354.2295** and the `median` total number of steps per day is **10395**.

The histogram of the total number of steps per day is: 


```r
histogram(daylytotal, breaks = 25, type = "count", col = "NA", 
                      xlab = "Total steps per day",
                      ylab = "Frequency")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

## What is the average daily activity pattern?

The code calculates the average steps per day, plots the steps with respect to the intervals and finds out the interval with maximum average steps.


```r
df <- aggregate(data, list(data$interval), mean, na.rm = TRUE)
df <- df[, c("interval","steps")]
        
plot (df$interval, df$steps, type = "l",  xlab = "Interval", 
                                          ylab = "Average steps")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

```r
maxsteps <- which(df$steps == max(df$steps))
maxSteps <- df[maxsteps, c("interval", "steps")]
maxSteps <- transform(maxSteps, interval = strftime(interval, format="%H:%M:%S"))
maxSteps
```

```
##     interval steps
## 104 08:35:00 206.2
```

The maximum average steps per interval is ***206.1698*** and they are during the time interval of ***08:35:00*** in the morning.

## Imputing missing values

The code inputs missing values in the data.frame with the average value for the specific interval in which` the missing values` value occurs. Afterwards, are calculated the total number of steps the mean and the median per day. The data is compared with the results before replacing `the missing values`


```r
totalNA <- sum(is.na(data))
        
stepsList <- split(data$steps, factor(data$interval))
stepsList <- lapply(stepsList, 
        function(stepsList){
                stepsList[which(is.na(stepsList))] <- mean(stepsList, na.rm = TRUE)
                stepsList
        })
        
fillData <- data
fillData$steps <- unsplit(stepsList, factor(fillData$interval)) 
        
fillDaylyTotal <- tapply(fillData$steps, factor(fillData$date), sum, na.rm = TRUE)
daylyTotal <- tapply(data$steps, factor(data$date), sum, na.rm = TRUE)
        
par(mfrow = c(2,1), mar = c(4,4,2,1), oma = c(0,0,2,0))
        
hist(daylyTotal, breaks = 25, xlab = "Total steps per day", 
                              main = "Data with NA values")
hist(fillDaylyTotal, breaks = 25, xlab = "Total steps per day",
                                  main = "NA values substituted with interval means")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

```r
fillMean <- mean(fillDaylyTotal)
fillMedian <- median(fillDaylyTotal)
```

As shown in the graph the total number of steps per day increased after replacing `the missing values` with the interval's average value. This makes the distribution steeper with better expressed mean value. However the increase in mean and median values after replacing `the missing values` is relatively small:

1. Mean value ***`before`*** NA replacement : 9354.2295
2. Mean value ***`after`***  NA replacement : 1.0766 &times; 10<sup>4</sup>
3. Median value ***`before`*** NA replacement : 10395
4. Median value ***`after`***  NA replacement : 1.0766 &times; 10<sup>4</sup>

## Are there differences in activity patterns between weekdays and weekends?

The code calculates the average steps per interval for each group of days `weekdays` and `weekends`. Furthermore, the data is processed in a format convenient for `xyplot` plotting function from `lattice` package.


```r
fDays<- factor((weekdays(data$date) %in% c('Saturday','Sunday')), 
                       labels = c("weekdays", "weekends"))
        
lDaysSteps <- split(fillData, fDays)
lDaysSteps <- lapply(lDaysSteps, 
                        function(x){
                                aggregate(x, list(x$interval), mean, na.rm = TRUE)
                        })
        
par(mfrow = c(2,1), mar = c(3,3,2,1), oma = c(0,0,2,0))

with(lDaysSteps[[2]], plot (Group.1, steps, type = "l", xlab = "Intervals", 
                                                        ylab = "Average steps",
                                                        main = "Weekend",
                                                        ylim = c(0, 200)))
        
with(lDaysSteps[[1]], plot (Group.1, steps, type = "l", xlab = "Intervals", 
                                                        ylab = "Average steps",
                                                        main = "Weekdays"))
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 

```r
weekendTotal <- sum(lDaysSteps[[2]]$steps)
weekTotal <- sum(lDaysSteps[[1]]$steps)
```

From the plots presented above it becomes evident that in the weekend the average number of steps in the different periods is more even during the day compared with the week days. There is a very well defined peak in the average number of steps before 9:00 am and few smaller peaks around lunch and before the end of the working day. However, it seems the area under the weekends' line is larger in comparison with the area under weekdays' line proposing the total number of steps is larger in the weekends, namely:

1. The total number of steps in the ***`weekend`*** is: 1.2202 &times; 10<sup>4</sup>  
2. The total number of steps in the ***`weekdays`*** is: 1.0256 &times; 10<sup>4</sup>

This proves that the subjects do more steps in the weekend in comparison with the weekdays.
