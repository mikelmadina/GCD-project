Files for Getting and Cleaning Data Course Project (Coursera, John Hopkins)

`run_analysis.R` script performs these operations:

- Download data, unzip and delete zip file
- load data from several files (train data, test data, subjects, activities)
- merge train and test datasets in 3 dataframes: xData, yData, subjects
- obtain indexes for mean and std related variables ["Extracts only the measurements on the mean and standard deviation for each measurement."]
- obtain "human readable" variable names for mean and std related variables
- delete special characters from variable names
- subset data for mean and std related variables into new DF
- apply "human readable" variable names to new DF
- rename "activity" variable and add to subset as new variable
- rename "subject" variable and add to subset as new variable
- convert new variables (subject and activity) to factors
- rename activity labels to "human readable" ones
- export tidy dataset
- aggregate and reorder by subject and activity [" create a second, independent tidy data set with the average of each variable for each activity and each subject."]
- export aggregated dataset

