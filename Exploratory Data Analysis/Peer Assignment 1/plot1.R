
# The following function "plot1" is the last part of the first peer assignment in 
# the fourt course from the "Data Scientist Specialisation" in Coursera:
# "Exploratory data research course". The function produces a single plot according to
# given criterias and saves the canvas in a png file with 480X480 pixels

plot1 <- function(){ 
        # Checks if "chron is installed in R and if not installs it"
        if (!is.installed("chron")){
                install.packages("chron")
        }
        library(chron)
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
        data$date <- as.Date(data$date, format="%d/%m/%Y") 
        data$time <- chron(times=data$time)
        
        # Extract only the data for first and second of February 2007
        f <- (data$date == as.Date("2007-02-01")) | (data$date == as.Date("2007-02-02")) 
        data <- data[f,]
        
        # Ensures the format of the plotting device
        par(mfcol = c(1,1))
        
        # Produces a histogram of the global active power variable
        hist(data$global.active.power,col="red", 
             xlab= "Global Active Power (kilowatts)", 
             main ="Global Active Power")
        
        # Copy the plot to png device
        dev.copy(png, file="plot1.png")
        dev.off()   
        
} 

# Simple function to check if a package is installed in R
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1])
