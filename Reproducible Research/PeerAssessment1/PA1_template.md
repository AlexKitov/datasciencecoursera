# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data


```r
fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
destFile <- "activity.zip"
dataFile <- "activity.csv"
if (!file.exists(dataFile)) {
        if (!file.exists(destFile)) {
                # If the destionation is unreachable download.file throws error
                download.file (fileURL, destFile, method = "internal")
        }
        unzip(destFile )
}  

data <- read.csv(file = dataFile, header = TRUE)
summary(data)
```

```
##      steps               date          interval   
##  Min.   :  0.0   01/10/2012:  288   Min.   :   0  
##  1st Qu.:  0.0   01/11/2012:  288   1st Qu.: 589  
##  Median :  0.0   02/10/2012:  288   Median :1178  
##  Mean   : 37.4   02/11/2012:  288   Mean   :1178  
##  3rd Qu.: 12.0   03/10/2012:  288   3rd Qu.:1766  
##  Max.   :806.0   03/11/2012:  288   Max.   :2355  
##  NA's   :2303    (Other)   :15840
```

## What is mean total number of steps taken per day?

```r
daylytotal <- tapply(data$steps, factor(data$date), sum, na.rm = TRUE)
totalStepsHist <- hist(daylytotal, breaks = 25, xlab = "Total steps per day")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

```r
mean <- mean(daylytotal)

median <- median(daylytotal)
```

