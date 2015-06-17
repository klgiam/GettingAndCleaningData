# Preparation:
# - Download data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# - unzip the files into a folder "D:\Project3\"
# - setwd("D:/Project3/"))

## Step 1: Merges the training and the test sets to create one data set.
## extract training data
train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
colnum <- ncol(train)
train[, colnum+1] <- read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
colnum <- ncol(train)
train[, colnum+1] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# extract test data
test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
colnum <- ncol(test)
test[, colnum+1] <- read.csv("UCI HAR Dataset/test//y_test.txt", sep="", header=FALSE)
colnum <- ncol(test)
test[, colnum+1] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

data = rbind(train, test)

## Step 2: 
## Extracts only the measurements on the mean and standard deviation for each measurement.
# features contains 2 columns V1 & V2. 
# V1 contains index of the columns in the main data set  
# V2 contains the descriptive names of columns in the main data set
# Extract out index of columns with the text "mean" & "std"
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
selected <- grep(".*std.*|.*Mean.*|.*mean.*", features[,2])

# Extract out columns in main data set with the text mean & std, 
# also appending the last 2 columns "activity" & "subject"
data2 <- data[c(selected, ncol(data)-1, ncol(data))]

## Step 3: 
## Uses descriptive activity names to name the activities in the data set
# activity_labels contains 2 columns V1 & V2:
# V1: numeric index 1 to 6 representing the activity
# V2: label of the activity
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Second last column in main data set data2 contains numeric index of activities
activityCol <- ncol(data2) - 1

# Convert the index numbers to corresponding activity label
for(i in activityLabels$V1) {
  label <- activityLabels$V2[i]  
  data2[,activityCol] <- gsub(i, label, data2[,activityCol])
}  


# Step 4: 
# Appropriately labels the data set with descriptive variable names. 
features2 <- features[selected,]
labels <- as.character(features2$V2)

# Remove special characters () & - in the labels 
labels <- gsub("\\(\\)", "",  labels)
labels <- gsub("-", "", labels)

# Capitalize M & S in mean & std
labels <- gsub("mean", "Mean", labels)
labels <- gsub("std", "Std",labels)

# Add labels of last 2 columns not found in features
labels[length(labels)+1] <- "activity"
labels[length(labels)+1] <- "subject"

# Rename labels of the data set 
names(data2) <- labels 

## Step 5: 
## From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.
data3 = aggregate(data2, by=list(activities = data2$activity, subjects=data2$subject), mean)

# exclude last 2 columns activity & subject as mean value is meaningless 
data3 <- data3[1:88]
write.table(data3, "tidy_data.txt", sep="\t", row.names = FALSE)

