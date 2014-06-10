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
        
        data <- read.csv(file = dataFile, header = TRUE, stringsAsFactors = FALSE)
        
        data$date <- as.Date(data$date, format = "%Y-%m-%d")
        
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
        
        par(mfrow = c(2,1), mar = c(3,3,2,0), oma = c(0,0,2,0))
        
        hist(daylyTotal, breaks = 25, xlab = "Total steps per day", 
             main = "Data with NA values")
        hist(fillDaylyTotal, breaks = 25, xlab = "Total steps per day",
             main = "NA values substituted with interval means",)
        
        fillMean <- mean(fillDaylyTotal)
        fillMeadin <- median(fillDaylyTotal)
}

lastOne <- function(){
        fDays<- factor((weekdays(data$date) %in% c('Saturday','Sunday')), 
                       labels = c("weekday", "weekend")) 
        
        lDaysSteps <- split(fillData, fDays)
        lDaysSteps <- lapply(lDaysSteps, 
                             function(x){
                                     x <- aggregate(x, list(x$interval), mean, na.rm = TRUE)
                                     x <- x[ , c("interval", "steps")]
                                     x
                             })
        
        lDaysSteps<-do.call(rbind, lDaysSteps)
        
        lDaysSteps <- cbind(rownames(lDaysSteps), lDaysSteps )
        rownames(lDaysSteps) <- seq(1:dim(lDaysSteps)[1])
       
        names(lDaysSteps) <- c("fday", "interval", "steps")

        splitNames <- strsplit(as.character(lDaysSteps$fday), ".", fixed = TRUE)        
        lDaysSteps$fday <- sapply(splitNames, function(x){x[1]} )
        lDaysSteps$fday <- as.factor(lDaysSteps$fday)
        
        daysSteps <<- lDaysSteps
        
        xyplot(steps~interval|fday, data=lDaysSteps, type = "l", layout=c(1,2))
}

lastOneTemp <- function(){
        fDays<- factor((weekdays(data$date) %in% c('Saturday','Sunday')), 
                       labels = c("weekdays", "weekends"))
        
        lDaysSteps <- split(fillData, fDays)
        lDaysSteps <- lapply(lDaysSteps, 
                             function(x){
                                     aggregate(x, list(x$interval), mean, na.rm = TRUE)
                             })
        
        par(mfrow = c(2,1), mar = c(3,3,2,1), oma = c(0,0,2,0))
        
        with(lDaysSteps[[1]], plot (Group.1, steps, type = "l", xlab = "Intervals", 
                                                               ylab = "Average steps"))
        
        with(lDaysSteps[[2]], plot (Group.1, steps, type = "l", xlab = "Intervals", 
                                                               ylab = "Average steps"))
        
}
