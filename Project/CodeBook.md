CodeBook for the Getting and Cleaning Data Course Project
=========================================================

This file describes the key steps performed by the run_analysis.R script to tidy the data.

* The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


* The key steps performed by run_analysis.R script clean the data:   
 1. Preparation:
  - Download data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  - unzip the files into a folder "D:\Project3\"
  - setwd("D:/Project3/"))
 2. Step 1: Merges the training and the test sets to create one data set.
  - extract training data X_train.txt into variable train
  - extract and add training activity data y_train.txt to variable train
  - extract and add training subject data subject_train.txt to variable train
  - extract test data X_test.txt into variable test
  - extract and add test activity data y_test.txt to variable test
  - extract and add test subject data subject_test.txt to variable test
  - rbind the variables train & test into the new variable data
 3. Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
  - extract the features.txt file into variable features
  - features contains 2 columns V1 & V2. 
  - V1 contains index of the columns in the main data set  
  - V2 contains the descriptive names of columns in the main data set
  - extract out index of columns with the text "mean" & "std" into variable selected
  - extract out columns in main data set with the text mean & std, & append the last 2 columns "activity" & "subject"
 4. Step 3: Uses descriptive activity names to name the activities in the data set
  - extract the activity_labels.txt into variable activity_labels
  - activity_labels contains 2 columns V1 & V2:
  - V1: numeric index 1 to 6 representing the activity
  - V2: label of the activity
  - Convert the index numbers to corresponding activity label by looping through the activity labels
 5. Step 4: Appropriately labels the data set with descriptive variable names. 
  - extract selected columns in features into new variable features2
  - extract second column of features2 into character vector labels
  - remove special characters () & - in labels 
  - capitalize M & S in mean & std of labels
  - Add to last 2 columns of labels "activity" & "subject"
  - rename labels of the data set data2
 6. Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - calculate aggregate mean group by activity & subject columns, adding result to data set data3 
  - exclude last 2 columns activity & subject in data3 as mean value is meaningless 
  - write data3 out to "tidy_data.txt" file