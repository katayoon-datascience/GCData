The Samsung Galaxy S II is a touchscreen-enabled, slate-format Android smartphone designed, developed, and marketed by Samsung Electronics. The original data for the project (available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is based on the experiments that have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING _ UPSTAIRS, WALKING _ DOWNSTAIRS, SITTING, STANDING, LAYING) wearing this smartphone (Samsung Galaxy S II) on the waist.
The information provided for each record includes:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables which represent measurements from the Samsung phone.
- Its activity label (basically what activity they were performing).
- An identifier of the subject who carried out the experiment.

The goal of this project is to obtain a tidy dataset by performing the following tasks on the original data:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.


In order to achieve these tasks and to obtain the desired tidy dataset an R script called run_analysis is run. For each of the steps mentioned above this R script (run_analysis) does the following:

1. Merge the training and the test sets to create one data set.
	* Reads the related training data from subject_train.txt (subjectTrain), X _train .txt (XTrain) and y_train.txt (YTrain).
	* Assigns row number as the values of ID column
	* merges subjectTrain, YTrain and XTrain to form the Training dataset
	* Reads the related test data from subject _ test.txt (subjectTest), X _ test .txt (XTest) and y_test.txt (YTest).
	* Assigns row number as the values of ID column
	* Merges subjectTest, YTest and XTest to form the Test dataset
	* Merges the Training and the Test sets to create Data dataset

2. Extract only the measurements on the mean and standard deviation for each measurement. 
	* Reads the features into the Features table
	* Extracts from the Features table those features that have "mean" and "std" in their names into selectedFeatures table.
	* Subsets the Data dataset to those items that have the extracted measurements in the previous step, the subset will be DataMeasurments dataset.

3. Use descriptive activity names to name the activities in the data set.
	* Reads the activity names from the activity_labels table into activityLabels.
	* Creates a new dataset (DataActivity) with the activity names by merging the DataMeasurments dataset from step 2 with the activityLabels.

4. Appropriately label the data set with descriptive variable names. 
	* Uses the selectedFeatures table from the step 2 to get descriptive variable names.
	* Labels DataActivity (from step 3) activity names with the variable names in the previous step.

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
	* Using the DataActivity dataset from step 4, creates a new dataset with the average of each variable for each activity and each subject. This will be the tidyData dataset.
	* Outputs the tidyData dataset to a text file as instructed in the project.

In addition to the files available in the directory related to the original data described in the ORIGINALREADME.txt file, the following files are found:

README.txt: This document describing the experiment, data and tasks performed to achieve the tidy dataset and how they relate each other.

CodeBook.md: Describes all the variables and summaries calculated for the course project, along with units, and any other relevant information.

run_analysis.r: The r script that completes the project and outputs the tidy dataset into a file called tidyData.txt.

tidyData.txt: the tidy dataset and output of the run_analysis script.
