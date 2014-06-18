data <- data.frame()
classifier <- data.frame()

plot2 <- function(){ 
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
        
        # Extracting the emissions for "Baltimore" - fips = "24510"
        baltimor <- which(data$fips == "24510")
        
        # Calculating the yearly total emissins for "Baltimore"
        yTotal <- with(data[baltimor, ], tapply(emissions, as.factor(year), sum))
        
        # Open a .png device
        png(filename = "plot2.png")
        
        # Setting up the margines of the plot
        par(mar = c(4.5, 4.5, 3, 1))
        
        # Scaling and plotting with the base plot system
        scale <- 1000
        plot(as.numeric(names(yTotal)), yTotal/scale, 
                                        ylim = range(yTotal)/scale,
                                        type = "b", 
                                        pch = "O",
                                        ylab = expression("Total PM"[2.5]*" , tones 10"^3),  
                                        xlab = "Year, y",
                                        lwd = 3,
                                        col = "blue",
                                        main = expression("Total PM"[2.5]*" emissions per year in Baltimore City"))
        dev.off()
}
