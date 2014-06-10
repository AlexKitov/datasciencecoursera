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
        
        data$date <- as.Date(data$date, format = "%d/%m/%Y")
        
        data$interval <- sprintf("%04d", data$interval)
        data$interval <- as.POSIXct(data$interval, format = "%H%M")
        
        data <<- data[, c("date", "interval", "steps")]
}

question2 <- function(){
        daylytotal <- tapply(data$steps, factor(data$date), sum, na.rm = TRUE)
        mean <- mean(daylytotal)
        median <- median(daylytotal)
        par(mfrow = c(1,1))
        hist(daylytotal, breaks = 25, xlab = "Total steps per day")
}

question3 <- function(){
        
        x <- aggregate(data, list(data$interval), mean, na.rm = TRUE)
        x <- x[, c("Group.1","steps")]
        names(x) <- c("interval","steps")
        
        plot (x$interval, x$steps, type = "l", xlab = "Interval", 
                                               ylab = "Average steps")
        maxsteps <- which(x$steps == max(x$steps))
        x[maxsteps, c("interval", "steps")]
}

inputNAval <- function(){
        totalNA <- sum(is.na(data))
        
        stepsList <- split(data$steps, factor(data$interval))
        stepsList <- lapply(stepsList, 
                function(stepsList){
                        stepsList[which(is.na(stepsList))] <- mean(stepsList, na.rm = TRUE)
                        stepsList
                })
        
        fillData <<- data
        fillData$steps <<- unsplit(stepsList, factor(fillData$interval)) 
        
        fillDaylyTotal <- tapply(fillData$steps, factor(fillData$date), sum, na.rm = TRUE)
        daylyTotal <- tapply(data$steps, factor(data$date), sum, na.rm = TRUE)
        
        par(mfrow = c(2,1), mar = c(4,4,2,1), oma = c(0,0,2,0))
        
        hist(daylyTotal, breaks = 25, xlab = "Total steps per day")
        hist(fillDaylyTotal, breaks = 25, xlab = "Total steps per day")
        
        fillMean <- mean(fillDaylyTotal)
        fillMeadin <- median(fillDaylyTotal)
}

lastOne <- function(){
        fDays<- factor((weekdays(data$date) %in% c('Saturday','Sunday')), 
                       labels = c("weekday", "weekend")) 
        lDaysSteps <- split(fillData, fDays)
        lDaysSteps <- lapply(lDaysSteps, 
                             function(x){
                                     aggregate(x, list(x$interval), mean, na.rm = TRUE)
                             })
        par(mfrow = c(2,1))
        
        with(lDaysSteps[[1]], plot (Group.1, steps, type = "l", xlab = "Intervals", 
                                    ylab = "Average steps"))
        
        with(lDaysSteps[[2]], plot (Group.1, steps, type = "l", xlab = "Intervals", 
                                    ylab = "Average steps"))
        plotdata <- do.call(rbind,lDaysSteps)
        
        xyplot(steps~Group.1|fDays, data=plotdata, layout=c(1,2))
}
