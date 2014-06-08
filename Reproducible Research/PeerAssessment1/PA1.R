data <- data.frame()
daymean <- data.frame()
question1 <- function(){
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
        data[,4] <- paste(data$date, data$interval, sep = " ")
        data[,4] <- strptime(data$date, format="%d/%m/%Y %H:%M")
        data$date <- as.Date(data$date, format="%d/%m/%Y")
        data <<- data[, c("date", "steps", "interval")]
}

question2 <- function(){
        daylytotal <- tapply(data$steps, factor(data$date), sum, na.rm = TRUE)
        totalStepsHist <- hist(daylytotal, breaks = 25, xlab = "Total steps per day")
        
        mean <- mean(daylytotal)
        
        median <- median(daylymedian)
}

question3 <- function(){
        x <- aggregate(data, list(data$interval), mean, na.rm = TRUE)
        x$interval <- levels(factor(data$interval))
        plot (x$interval, x$steps, type = "l", xlab = "Intervals")
        max
}

question4 <- function(){
        
}

