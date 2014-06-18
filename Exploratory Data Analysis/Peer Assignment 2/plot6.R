data <- data.frame()
classifier <- data.frame()

plot6 <- function(){ 
        library(ggplot2)
        # Check for existing dataset and unzip if necessary
        # This assignment uses data from the UC Irvine Machine Learning Repository, 
        # a popular repository for machine learning datasets. In particular, 
        # we will be using the "Individual household electric power consumption Data Set"
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
        
        # Define the corresponding U.S. county indicators
        fipBaltimor <- "24510"
        fipLA       <- "06037"
        
        # Read the emissins and source classifiers data
        data <<- readRDS(dataFile)
        classifier <<- readRDS(classFile)
        
        # Processing the names of the dataframes
        names(data) <- tolower(names(data))
        names(classifier) <- tolower(names(classifier))
        
        # Extracting the classifier numbers representing any sort of "Vehicle" source
        vehicleScc <- classifier[grep(("[V|v]ehicle"), classifier$ei.sector), "scc"]
        vehicleScc <- as.character(vehicleScc)
        
        # Subsetting the data by source ("Vehicle") and U.S. county
        # respectivly for Baltimor and LA
        vehBalt <- subset(data, (scc %in% vehicleScc)&(fips == fipBaltimor))
        vehLA   <- subset(data, (scc %in% vehicleScc)&(fips == fipLA))
        
        # Calculating the yearly total emissions, 
        # respectivly for Baltimor and LA
        yVehBaltTotal <- with(vehBalt, 
                              aggregate(emissions, by = list(as.factor(year)), sum))
        
        yVehLATotal   <- with(vehLA, 
                              aggregate(emissions, by = list(as.factor(year)), sum))
        
        # Seting up the names of the aggregated data.frames()
        names(yVehBaltTotal) <- c("year", "emissions")
        names(yVehLATotal)   <- c("year", "emissions")
        
        # Ploting the data with a layered ggplot function
        ggplot(yVehBaltTotal, aes(x = year, y = emissions, group = 0)) +
                
                # Ploting the "Baltimor" data declared in ggplot()
                geom_point(aes(colour = "Baltimor"), size = 4) +
                geom_line(aes(colour = "Baltimor"), size = 1) +
                
                # Ploting the "LA" data declared below
                geom_point(data = yVehLATotal, aes(y = emissions, group = 1, colour = "LA"), size = 4) +
                geom_line(data = yVehLATotal, aes(y = emissions, group = 1, colour = "LA"), size = 1) +
                
                # Formating the plot title, y axis label, name of the legend
                labs(title = "Total vehicle-related emissions", 
                     y = expression("Emissions PM"[2.5]* " , tons"), 
                     colour = "County") +
                
                # Setting the plot title size
                theme(plot.title = element_text(size = 20), legend.position="bottom") 
        
        # Saving the plot in .png file
        ggsave(filename = "plot6.png", width = 4.8, height = 4.8, dpi = 120)
        
        
}