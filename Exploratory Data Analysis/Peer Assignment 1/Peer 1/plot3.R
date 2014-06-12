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

# Plot 3 generation
png(file = "plot3.png", width = 480, height = 480, bg = "transparent")
with(DF, plot(Date_Time, Sub_metering_1,
              type = "n", xlab = "", ylab = "Energy sub metering")
)
with(DF, lines(Date_Time, Sub_metering_1))
with(DF, lines(Date_Time, Sub_metering_2, col = "red"))
with(DF, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()