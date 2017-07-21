# GettingAndCleaningDataFinalAssignment

The R script in this repository will perform an analysis on the Samsung dataset located here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

When calling the function, pass in the path to the "Dataset" folder that houses all the data this script works with.  After the script runs, there will be two new data tables written to disk in your working directory: 

dataSetMeansAndDevsOnly.txt contains the un-summarized data for all subjects and activities, for all the mean and standard deviation features in the raw data

avgPerSubjectPerActivity.txt contains summarized data by subject and activity, calculating the mean value of all measurements for each feature, grouped by subject and activity
