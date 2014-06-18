data <- data.frame()
classifier <- data.frame()

plot3 <- function(){ 
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
        
        # Processing the names of the data.frames()
        names(data) <- tolower(names(data))
        names(classifier) <- tolower(names(classifier))
        
        # Extracting the emissions for "Baltimore" - fips = "24510"
        baltimor <- which(data$fips == "24510")
        
        # Calculating the yearly total emissions for "Baltimore" 
        # measured by certain type of source
        yTypeTotal <- with(data[baltimor, ], 
                       aggregate(emissions, 
                                 by = list(as.factor(type), as.factor(year)), sum))
        
        # Seting up the names of the aggregated data.frames()
        names(yTypeTotal) <- c("type", "year", "emissions")
        
        # Ploting the data with a layered ggplot function
        ggplot(yTypeTotal, aes(x = year, y = emissions, group = type) )+
                # Uncoment to plot in 4 separate graphs
                #facet_wrap(~type, ncol=2) + 
                
                # Plotting the data declared in ggplot()
                geom_point(aes(col=type), size = 4)+
                geom_line(aes(col=type), size = 1)+
                
                # Formating the plot title, y axis label, name of the legend
                labs(title = "Emissions by type of sourcess", 
                     y = expression("Emissions PM"[2.5]* " , tons"),
                     colour = "Point type") +
                
                # Setting the plot title size
                theme(plot.title = element_text(size = 20))
        
        # Saving the plot in .png file
        ggsave(filename = "plot3.png", width = 6, height = 4.5, dpi = 1200)
        
}
