## borrador de codigo para el proyecto de GCD

# Download data, unzip and delete zip file

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","datafiles.zip")
unzip("datafiles.zip")
unlink("datafiles.zip")

# load data
## train data
traindir <- paste0(getwd(),"/UCI HAR Dataset/train")
x_train <- read.table(paste0(traindir,"/X_train.txt"), header = F)
y_train <- read.table(paste0(traindir,"/y_train.txt"), header = F)
subjectsTrain <- read.table(paste0(traindir,"/subject_train.txt"), header = F)


## test data
testdir <- paste0(getwd(),"/UCI HAR Dataset/test")
x_test <- read.table(paste0(testdir,"/X_test.txt"), header = F)
y_test <- read.table(paste0(testdir,"/y_test.txt"), header = F)
subjectsTest <- read.table(paste0(testdir,"/subject_test.txt"), header = F)

## activity labels
activityLabels <- read.table(paste0(getwd(),"/UCI HAR Dataset/activity_labels.txt"), header = F)

# merge datasets
xData <- rbind(x_train, x_test)
yData <- rbind(y_train, y_test)
subjects <- rbind(subjectsTrain, subjectsTest)


# obtain indexes for mean and std related variables
variableIndexes <- (variableNames[grep("mean|std",variableNames$V2),1])
variableIndexes <- paste0("V",variableIndexes)

# obtain "human readable" variable names for mean and std related variables
variableNames <- read.table("UCI HAR Dataset/features.txt")
variableNames <- (variableNames[grep("mean|std",variableNames$V2),2])

# delete special characters from variable names
variableNames <- gsub("\\(|\\)|-","",variableNames)

# subset data for mean and std related variables
newXData <- subset(xData, select = variableIndexes)

# apply "human readable" variable names to subset
colnames(newXData) <- variableNames

# rename "activity" variable and add to subset
colnames(yData)[1] <- "activity"
newXData <- cbind(newXData, yData)

# rename "subject" variable and add to subset
colnames(subjects)[1] <- "subject"
newXData <- cbind(newXData, subjects)

# convert new variables to factors
newXData$activity <- as.factor(newXData$activity)
newXData$subject <- as.factor(newXData$subject)

# rename activity labels to "human readable" ones
levels(newXData$activity) <- activityLabels$V2

# Export tidy dataset
write.csv(newXData, "tidyData.csv")

# aggregate and reorder by subject and activity
new.df <- aggregate( . ~ subject + activity, data = newXData, mean)
new.df <- new.df[order(new.df$subject, new.df$activity),]

# Export aggregated dataset
write.csv(new.df, "means_by_subject_and_activity.csv")
