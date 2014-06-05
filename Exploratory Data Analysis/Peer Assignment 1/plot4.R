# The following function "plot4" is the last part of the first peer assignment in 
# the fourt course from the "Data Scientist Specialisation" in Coursera:
# "Exploratory data research course". The function produces four plots according to
# given criterias and saves the canvas in a png file with 480X480 pixels

plot4 <- function(){ 
        # Check for existing dataset and unzip if necessary
        # This assignment uses data from the UC Irvine Machine Learning Repository, 
        # a popular repository for machine learning datasets. In particular, 
        # we will be using the “Individual household electric power consumption Data Set”
        # which I have made available on the course web site:
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        destFile <- "exdata-data-household_power_consumption.zip"
        dataFile <- "household_power_consumption.txt"
        if (!file.exists("household_power_consumption.txt")) {
                if (!file.exists("exdata-data-household_power_consumption.zip")) {
                        # If the destionation is unreachable download.file throws error
                        download.file (fileURL, destFile, method = "internal")
                }
                unzip("exdata-data-household_power_consumption.zip")
        }  

        data <- read.table(dataFile, sep=";", na.strings = "?", header = TRUE)
        
        # Clean the names of the table and lowercase
        names(data) <- gsub("[[:punct:]]", ".", names(data))
        names(data) <- tolower(names(data))
        
        
        # Paste Data and Time columns into Data column and convert in to POSIXct format
        # also remove the Time column
        data$date <- paste(data$date, data$time, sep=" ") 
        data$date <- strptime(data$date, format="%d/%m/%Y %H:%M:%S")
        data <- data[,-2]
        
        # Extract only the data for first and second of February 2007
        f <- (data$date > as.POSIXct("2007-02-01")) & (data$date < as.POSIXct("2007-02-03")) 
        data <- data[f,]
        
        
        par(mfcol = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
        
        with(data,{
        # Plot1 - produce a plot with global active power by time
                plot(date, global.active.power, type = "l", 
                        ylab= "Global Active Power (kilowatts)",
                        xlab= "")
        
        # Plot2 - produce a plot with sub meetiering 1 by time
                plot(date, sub.metering.1, type = "l", 
                        ylab= "Energy sub metering", xlab= "")
        
                # Add two lines for submetering 2 and 3
                lines(date, sub.metering.2, col ="red")
                lines(date, sub.metering.3, col ="blue")
        
                # Add a legend
                legend("topright", col = c("black", "red", "blue"),lwd=2, 
                        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
                
        # Plot3 -  producing a plot with the voltage     
                plot(date, voltage, type = "l", 
                        ylab= "Voltage", xlab= "datetime")
        
        # Plot4 -  producing a plot with the Global Reactive Power 
                plot(date, global.reactive.power, type = "l", 
                        ylab= "Global_reactive_power", xlab= "datetime")
        })
        
        # Copy the plot to png device
        dev.copy(png, file="plot4.png")
        dev.off()        
} 
