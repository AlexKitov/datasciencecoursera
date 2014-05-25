data <- data.frame()
sampledata <- data.frame()
tidydata <- data.frame()
mergedata <- function(lowercase = TRUE){
        #check if the data exist in the working directory. 
        #if not, checks for the .zip file and tries to unzip the file
        #if fail to unzip stops the function with a message for missing data
        if (!file.exists("UCI HAR Dataset")) {
                if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
                        stop("was expecting HAR Dataset folder or .zip file")
                } else {
                        unzip("getdata-projectfiles-UCI HAR Dataset.zip")
                }
        }
        
        # load the paths to the used files in a variables
        activitiesF     <- "./UCI HAR Dataset/activity_labels.txt"
        featuresF       <- "./UCI HAR Dataset/features.txt"
        
        activityTestF   <- "./UCI HAR Dataset/test/y_test.txt"
        subjectTestF    <- "./UCI HAR Dataset/test/subject_test.txt"
        xTestFile       <- "./UCI HAR Dataset/test/X_test.txt"
        
        activityTrainF  <- "./UCI HAR Dataset/train/y_train.txt"
        subjectTrainF   <- "./UCI HAR Dataset/train/subject_train.txt"
        xTrainFile      <- "./UCI HAR Dataset/train/X_train.txt"
        
        #read the test data from different files
        testdata <- readdata(activityTestF, subjectTestF, xTestFile)
        
        #read the training data from different files
        traindata <- readdata(activityTrainF, subjectTrainF, xTrainFile)
        
        #merge the data in an complete data.frame 
        mergeddata <- rbind(testdata, traindata)
        
        
        #clen and set the data.frame names
        features <- read.table(featuresF, colClasses="character")
        colnames <- cleanstr(c("activity", "subject", features[,2]),"", lowercase)
        names(mergeddata) <- colnames
        
        #get the activities corresponding to the numbers in the already read data
        activityNames <- read.table (activitiesF, sep = "", colClasses=character())
        activityNames <-cleanstr(activityNames[,2], "", lowercase)
        
        #change the activity classes with readable names
        mergeddata$activity <- as.factor(mergeddata$activity)
        levels(mergeddata$activity) <- activityNames
        mergeddata$activity <- as.character(mergeddata$activity)
        
        #sort the data.frame first by activity and then by subject
        mergeddata <- mergeddata[order(mergeddata$activity, mergeddata$subject), ]
        
        #save the merged data in the global environment
        data <<- mergeddata
        
        #extract only the mean and stdev variables 
        #save the sample in the global environment 
        sampledata <<- mergeddata[,c(1, 2, grep(("[M|m]ean|[S|s]td"), names(mergeddata)))]
        
        #construct the tidy data and save it in the global environment
        tidydata <<- tidyData(sampledata)
        
        #write all the data in separate files 
        write.table(data,"./data.csv",sep=",")
        write.table(sampledata,"./sampledata.csv",sep=",")
        write.table(tidydata,"./tidydata.csv",sep=",",)
}

tidyData <- function(df = data.frame()){
        #load the library for the "melat" and "dcast"
        library(reshape2)
        
        #reshape the data so the mean of each variable is calculated 
        #by "activity" and "subject", where activity is with higher priority
        df <- melt(df, c("subject", "activity"))
        df <- dcast(df, activity+subject~variable, mean)
        
        df
}
#Removing all the unnecesary symbols and further processing the names
#The function receives 2 parameters:
#        I. strvect - character vector to bre processed
#       II. tolower - bolean, indicationg if the names should be low-capitalized
#The function returns character vector with the same lenght as "strvect"
cleanstr <- function(strvect = character(), separator ="", tolower = FALSE){
        library(stringr)
        
        #[[:punct:]] regular expresions to remove all "punctuation characters"
        #according to wekepedia these are: [\]\[!"#$%&'()*+,./:;<=>?@\^_`{|}~-]
        strvect <- gsub("[[:punct:]]", separator, strvect)
        
        #remove white spaces at the end of the string
        strvect <- str_trim(strvect)
        if (tolower){
                strvect <- tolower(strvect)    
        }
        strvect
}

readdata <- function(activityFile=character(), 
                     subjectFile=character(), 
                     varFile=character()){
        
        # reading the activity column vector from a specified file
        activity <- read.table(activityFile)
        
        # reading the subjects column vector from a specified file
        subject <- read.table(subjectFile)
        
        # reading the variable data.frame from a specified file
        data <- read.table(varFile)
        
        #return data frame binded by columns
        cbind(activity, subject, data)       
}
