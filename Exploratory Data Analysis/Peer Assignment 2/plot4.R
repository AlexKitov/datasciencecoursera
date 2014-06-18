data <- data.frame()
classifier <- data.frame()

plot4 <- function(){ 
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
        
        # Extracting the classifier numbers representing any sort of "Coal" source
        CoalScc <- classifier[grep(("[C|c]oal"), classifier$ei.sector), "scc"]
        CoalScc <- as.character(CoalScc)
        
        # Subsetting the data by source ("Coal")
        CoalCombScc <- data$scc %in% CoalScc
        CoalCombData <- data[CoalCombScc, ]
        
        # Calculating the yearly total emissions from "Coal"
        yCoalTotal <- with(CoalCombData, 
                       aggregate(emissions, by = list(as.factor(year)), sum))
        
        # Seting up the names of the aggregated data.frames()
        names(yCoalTotal) <- c("year", "emissions")

        # Scaling down the emissions 1000 times
        scale <- 1000
        yCoalTotal$emissions <- yCoalTotal$emissions/scale
        
        # Ploting the data with a layered ggplot function
        ggplot(yCoalTotal, aes(x = year, y = emissions, group = 0)) +
                
                # Plotting the data declared in ggplot()
                geom_point(size = 4) +
                geom_line(size = 1) +
                
                # Formating the plot title, y axis label, name of the legend
                labs(title = "Total coal-related emissions", 
                     y = expression("Emissions PM"[2.5]* " , tons 10"^3)) +
                
                # Setting the plot title size
                theme(plot.title = element_text(size = 20))
        
        # Saving the plot in .png file
        ggsave(filename = "plot4.png", width = 4.8, height = 4.8, dpi = 120)
}
