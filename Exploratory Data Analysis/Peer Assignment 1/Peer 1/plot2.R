# Locale definition
Sys.setlocale("LC_TIME", "English")
library(sqldf)
# File definition
file <- file("household_power_consumption.txt")

# Data load
DF <- sqldf("select * from file where Date = '1/2/2007' or
            Date = '2/2/2007'",
            file.format = list(sep = ";", header = TRUE)
            
)
close(file)

# Date transform
DF <- transform(DF, Date_Time = strptime(
        paste(Date, Time, sep = " "), "%d/%m/%Y %H:%M:%S")
)

# Plot 2 generation
png(file = "plot2.png", width = 480, height = 480, bg = "transparent")
plot(DF$Date_Time, DF$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()