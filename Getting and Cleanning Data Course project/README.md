### Introduction

This script was developed as part of a course project for Getting and cleaning data course part of Coursera's Data Scientist Specialization.

The script works with data from "Human Activity Recognition Using Smartphones" experiments performed by Smartlab - Non Linear Complex Systems Laboratory in
`DITEN - Università degli Studi di Genova`. 

The script `run_analysis.R` perform readings from several files from the provided data and returns tidy dataset for further analysis as required for course project. The following  requirements should be met to allow for the proper functioning of the script:

* the script file `run_analysis.R` is placed in the R's working directory
* the working dataset is also placed in the working directory by one of the following two ways:
	1. as a `getdata-projectfiles-UCI HAR Dataset.zip` file - in which case the script will unzip the file.
	2. already unzipped data - in which case the script will search for folder called `UCI HAR Dataset`.
* the package `plyr` is installed `install.packages("plyr")` and necessary loaded. 
* the package `reshape2` is installed  `(install.package("reshape2"))` and necessary loaded.

### Description of main function mergedata

The main function of the script is `mergedata()`. The function performs several actions during execution:

1. checks if the the necessary folder or .zip file exists in the working directory.
2. loads the paths to the files containing the data used in the transformation, which are:
	2.1 `activity_labels.txt` - descriptive labels for the activities performed by the participants in the experiment.
	2.2 `features.txt` - names of the variables calculated from the raw measurements during the experiment.
	2.3 `y_(test|train).txt` - contains a column vector representing the activity performed by the subject.
	2.4 `subject_(test|train).txt` - contains a column vector representing the subject who performed the activity.
	2.5 `X_(test|train).txt` - contains a multiple (563) column vectors representing variables calculated from the raw data from the experiment and matched by activity and subject.
3. reads the data for the test subjects and stores it in internal data.frame `testdata`
4. reads the data for the training subjects and stores it in internal data.frame `traindata`
5. stores the two datasets in a single data.frame by rows
6. reads the variable names from file `features.txt` and cleaning them with `cleanstr` referring to https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
7. set the `mergeddata`(data.frame) names with the processed names from 6. Additionally first column name is set to `activity` and the second as `subject`
8. set the activity values from the file `activitu_labels.txt` The values are processed with `cleanstr` before applied.
9. sort the `mergeddata` data.frame first by activity and second by subject
10. extract only variables which has `mean` OR `std` in the name, also accounting for capital first latter.
11. construct tidy dataset from the data from the previous step.
12. write all the data into .csv files 

### Function of `cleanstr`

cleanstr is used to process the names of the variables and activities before they are applied to the data.frame

####Syntax

cleanstr(strvect = character(), separator ="", tolower = FALSE)

#### Description
 
`cleandstr` removes the punctual characters from the elements of a character vector passed to the strvect parameter of the function.
The set of cleaned characters includes: `\]\[!"#$%&'()*+,./:;<=>?@\^_`{|}~-` . The function loads stringr package providing the str_trim function. The function gsub() is used for the cleaning of the names, with value of the argument pattern = "[[:punct:]]"   

#### Arguments

`separator` - character - used as a substitute of the punctual characters. It is included since according to [REFEFEFEFEF] the variable names in R should be with "." separator of the words. the PROBEM WITH "()" combination
`tolower` - boolean - its value determines weather or not the capital letters in the strvect elements should be replaced with lower ones. 
 
### Function of `tidyData`

The function tidyData is used to calculate the average by "activity" and "subject" for each variable. 

#### Syntax

tidyData <- (df = data.frame())

####Description

The function tidyData is used to calculate the average by "activity" and "subject" for each variable. The function requires the installation of  reshape2 package in advance. The function then loads the package with library(reshape2). Afterwords the data is melted to a slim long data.frame by "activity" and "subject" and cast back to form a 180 rows by 88 columns tidy data.frame used as a final result for the course project 

####Arguments

`df` - data.frame - the input data from which the tidy data is constructed 

### Function of `readdata`

The function readdata is used to read a set of tree fails and to combine them in a data.frame with proper format (by columns- "activity", "subject", 563 variables)

####Syntax

readdata <- function(activityFile=character(), subjectFile=character(), varFile=character())

####Arguments

The arguments are tree character vectors containing the paths of the three fails need to for constructing the data. 

`activityFile` - character - contains a vector indicating the activity performed by the subject 
`subjectFile` - character - contains a vector indicating the subject who performed the activity  
`varFile` - character - contains 563 column vectors representing calculated variables from the raw data of the experiments

<!-- -->

	mergedata <- function(){
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
        colnames <- cleanstr(c("activity", "subject", features[,2]))
        names(mergeddata) <- colnames
        
        #get the activities corresponding to the numbers in the already read data
        activityNames <- read.table (activitiesF, sep = " ", colClasses=character())
        activityNames <-cleanstr(activityNames[,2],".",TRUE)
        
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
        write.table(tidydata,"./tidydata.csv",sep=",")
	}

<!-- -->

	tidyData <- function(df = data.frame()){
        #load the library for the "melat" and "dcast"
        library(reshape2)
        
        #reshape the data so the mean of each variable is calculated 
        #by "activity" and "subject", where activity is with higher priority
        df <- melt(df, c("subject", "activity"))
        df <- dcast(df, activity+subject~variable, mean)
        
        df
	}
<!-- -->

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
<!-- -->
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

