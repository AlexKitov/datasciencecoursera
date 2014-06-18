data <- data.frame()
classifier <- data.frame()

plot5 <- function(){ 
        library(ggplot2)
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
        
        # Processing the names of the dataframes
        names(data) <- tolower(names(data))
        names(classifier) <- tolower(names(classifier))
        
        # Extracting the classifier numbers representing any sort of "Vehicle" source
        vehicleScc <- classifier[grep(("[V|v]ehicle"), classifier$ei.sector), "scc"]
        vehicleScc <- as.character(vehicleScc)
        
        # Subsetting the data by source ("Vehicle") 
        # and U.S. county "Baltimor" - fips == "24510"
        vehicleData <- subset(data, (scc %in% vehicleScc)&(fips == "24510"))
        
        # Calculating the yearly total emissions for "Baltimore"
        yVehicleTotal <- with(vehicleData, 
                       aggregate(emissions, by = list(as.factor(year)), sum))
        
        # Seting the names of the aggregated data.frame()
        names(yVehicleTotal) <- c("year", "emissions")
        
        # Ploting the data with a layered ggplot function
        ggplot(yVehicleTotal, aes(x = year, y = emissions, group = 0)) +
                
                # Ploting the "Baltimor" data declared in ggplot()
                geom_point(size = 4) +
                geom_line(size = 1) +
                
                # Formating the plot title, y axis label
                labs(title = "Total vehicle related emissions", 
                     y = expression("Emissions PM"[2.5]* " , tons")) +
                
                # Setting the plot title size
                theme(plot.title = element_text(size = 20))
        
        # Saving the plot in .png file
        ggsave(filename = "plot5.png", width = 6, height = 4.5, dpi = 1200)
        
}
