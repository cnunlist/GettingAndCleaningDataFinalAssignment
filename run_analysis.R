run_analysis <- function(dataDirectory) {

  xtrain <- read.table(file.path(dataDirectory,"Train/X_train.txt"), sep = "", header = FALSE, stringsAsFactors = FALSE)
  ytrain <- read.table(file.path(dataDirectory,"Train/y_train.txt"), sep = "", header = FALSE, stringsAsFactors = FALSE)
  train_subject <- read.table(file.path(dataDirectory,"Train/subject_train.txt"), sep = "", header = FALSE, stringsAsFactors = FALSE)
  
  xtest <- read.table(file.path(dataDirectory,"Test/X_test.txt"), sep = "", header = FALSE, stringsAsFactors = FALSE)
  ytest <- read.table(file.path(dataDirectory,"Test/y_test.txt"), sep = "", header = FALSE, stringsAsFactors = FALSE)
  test_subject <- read.table(file.path(dataDirectory,"Test/subject_test.txt"), sep = "", header = FALSE, stringsAsFactors = FALSE)
  
  # combine training and test sets
  xcombined <- rbind(xtrain, xtest)
  ycombined <- rbind(ytrain, ytest)
  subject_combined <- rbind(train_subject, test_subject)
  
  # Add feature names
  features <- read.table(file.path(dataDirectory,"features.txt"), sep="", header = FALSE, stringsAsFactors = FALSE)
  colnames(xcombined) <- features[,2]
  colnames(ycombined) <- "activity"
  colnames(subject_combined) <- "subject"
  
  # map activity labels
  activity_labels <- read.table(file.path(dataDirectory,"activity_labels.txt"), sep="", header = FALSE, stringsAsFactors = FALSE)
  activities <- inner_join(ycombined, activity_labels, by = c("activity" = "V1"))
  colnames(activities) <- c("id","activity")
  
  # add subject and activity columns to the raw data
  fulldataset <- cbind(subject_combined, xcombined, activities)
  
  # extract just the subject/activity and the features that were mean/std related
  means_and_devs <- fulldataset[,grep("subject|-mean|-std|activity", names(fulldataset), ignore.case = TRUE)]
  
  # group data by subject and activity, then get mean of all features for this grouping
  grp_subject_activity <- group_by(means_and_devs, subject, activity)
  avg_per_subject_per_activity <- summarise_all(grp_subject_activity, mean)
  
  # export both the full data and the summarized data
  write.table(means_and_devs, "dataSetMeansAndDevsOnly.txt", row.name = FALSE)
  write.table(avg_per_subject_per_activity, "avgPerSubjectPerActivity.txt", row.name = FALSE)
}
