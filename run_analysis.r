#1. Merge the training and the test sets to create one data set.

# Read related training data:
subjectTrain = read.table("train/subject_train.txt", col.names=c("subject_id"))
XTrain = read.table("train/X_train.txt")
YTrain = read.table("train/y_train.txt", col.names=c("activity_id"))

# assign row number as the values of ID column
subjectTrain$ID <- as.numeric(rownames(subjectTrain))
XTrain$ID <- as.numeric(rownames(XTrain))
YTrain$ID <- as.numeric(rownames(YTrain))

# merge subjectTrain, YTrain and XTrain to form the training dataset
Train <- merge(subjectTrain, YTrain, all=TRUE)
Train <- merge(Train, XTrain, all=TRUE)

# Read related test data:
subjectTest = read.table("test/subject_test.txt", col.names=c("subject_id"))
XTest = read.table("test/X_test.txt")
YTest = read.table("test/y_test.txt", col.names=c("activity_id"))

# assign row number as the values of ID column
subjectTest$ID <- as.numeric(rownames(subjectTest))
XTest$ID <- as.numeric(rownames(XTest))
YTest$ID <- as.numeric(rownames(YTest))

# merge subjectTest, YTest and XTest to form the test dataset
Test <- merge(subjectTest, YTest, all=TRUE) 
Test <- merge(Test, XTest, all=TRUE) 

# rbind the Train and Test datasets
Data <- rbind(Train, Test)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.

#Read features
Features = read.table("features.txt", col.names=c("feature_id", "feature_label"),)

#Extract the mean and standard deviation
selectedFeatures <- Features[grepl("mean()", Features$feature_label, fixed = TRUE) | grepl("std()", Features$feature_label, fixed = TRUE), ]

#Dataset with the extracted measurments
DataMeasurments=Data[,c(c(1, 2, 3), selectedFeatures$feature_id + 3)]

# 3.Uses descriptive activity names to name the activities in the data set.
#Red the activity names
activityLabels = read.table("activity_labels.txt", col.names=c("activity_id", "activity_label"),)

#Dataset with the activity names
DataActivity=merge(DataMeasurments,activityLabels)

# 4.Appropriately labels the data set with descriptive activity names.
selectedFeatures$feature_label = gsub("\\(\\)", "", selectedFeatures$feature_label)
####selected_features$feature_label = gsub("-", ".", selected_features$feature_label)
for (i in 1:length(selectedFeatures$feature_label)) {
  colnames(DataActivity)[i + 3] <- selectedFeatures$feature_label[i]
}


# 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Data2 <- DataActivity[,!(names(DataActivity) %in% c("ID","activity_label"))]

#average of each variable for each activity
Data2Activity <-aggregate(Data2, by=list(subject = Data2$subject_id, activity = Data2$activity_id), FUN=mean, na.rm=TRUE)

#average of each variable for each activity and each subject
Data2ActivitySubject <- Data2Activity[,!(names(Data2Activity) %in% c("subject","activity"))]
TidyData = merge(Data2ActivitySubject, activityLabels)

#Write the data in the text file
write.table(x=TidyData,file="tidyData.txt",row.names=FALSE )
