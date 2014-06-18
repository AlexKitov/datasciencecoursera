data <- data.frame()
classifier <- data.frame()

plot1 <- function(){ 
        # Check for existing dataset and unzip if necessary
        # This assignment uses data from the UC Irvine Machine Learning Repository, 
        # a popular repository for machine learning datasets. In particular, 
        # we will be using the “Individual household electric power consumption Data Set”
        # which I have made available on the course web site:
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        zipFile <- "exdata-data-NEI_data.zip"
        dataFile <- "summarySCC_PM25.rds"
        classFile <- "Source_Classification_Code.rds"
        if (!file.exists(dataFile) & !file.exists(classFile)) {
                if (!file.exists(zipFile)) {
                        # If the destionation is unreachable download.file throws error
                        download.file (fileURL, zipFile, method = "internal")
                }
                unzip(zipFile)
        }  
        
        # Read the emissins and source classifiers data
        data <<- readRDS(dataFile)
        classifier <<- readRDS(classFile)
        
        # Processing the names of the data.frames()
        names(data) <- tolower(names(data))
        names(classifier) <- tolower(names(classifier))
        
        # Calculating the yearly total emissions of particulate matter
        yTotal <- with(data, tapply(emissions, as.factor(year), sum))

        # Scaling the y-axes 
        scale <- 1000000
        
        # Open .png device and set the margines for the plot
        png(filename = "plot1.png")
        par(mar = c(4.5, 4.5, 3, 1))
        
        # Plotting with the base plot system
        plot(as.numeric(names(yTotal)), yTotal/scale, 
                                        ylim = range(yTotal)/scale,
                                        type = "b",
                                        pch = "O",
                                        xlab = "Year, y",
                                        ylab = expression("Total PM"[2.5]*", tones 10"^6),
                                        lwd = 3,
                                        col = "blue",
                                        main = expression("Total PM"[2.5]*" emissions per year in U.S.A"))
        dev.off()
}
