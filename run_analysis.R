## Loads the data into R, giving appropriate names for the variables

## - 'features.txt': List of all 561 features with their names (561 variables)
features <- read.table("./UCI HAR Dataset/features.txt")
## - 'activity_labels.txt': Links the class labels with their activity name (6 activities)
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

## train tables: 7352 records

## - 'train/X_train.txt': training set. 561 variables
## - 'train/y_train.txt': training labels (labels from activity_labels.txt). 1 variable.
## - 'train/subject_train.txt': Each row identifies the subject who performed the activity for 
## each window sample. Its range is from 1 to 30. 1 variable.
## Sets the name of the variables for these datasets
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

## test tables: 2947 records

## - 'test/X_test.txt': test set. 561 variables
## - 'test/y_test.txt': test labels (labels from activity_labels.txt). 1 variable.
## - 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 1 variable.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

## Merges train tables together
train <- cbind(subject_train, Y_train, X_train)

## Merges test tables together
test <- cbind(subject_test, Y_test, X_test)

## 1. Merges the training and the test sets to create one data set.
all_data <- rbind(train, test)str(all_data_activity)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
chosen <- as.character(features[,2])    ## creates a vector of w/ features names character type
mean <- grep("mean", chosen)            ## returns the position of the features w/ 'mean'
Mean <- grep("Mean", chosen)            ## returns the position of the features w/ 'Mean'
std <- grep("std", chosen)              ## returns the position of the features w/ 'std'
col_read <- c(mean, Mean, std)          ## creates a vector w/ the positions to be extracted
col_read <- sort(col_read) + 2          ## sorts 'col_read' and adds 2 
mean_std <- all_data[,c(1,2,col_read)]  ## extracts the data adding the first 2 columns

## 3. Uses descriptive activity names to name the activities in the data set
all_data_activity <- merge(all_data, activity, by.x = "activity_id", by.y = "id")

## 4. Appropriately labels the data set with descriptive variable names. - Done

## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.
library(dplyr)

## Creates a new variable subject/ activity
all_data_activity$subj_act <- paste(all_data_activity$subject, all_data_activity$activity)
## Gets the average for each subject/ activity
subset_subj_act <- all_data_activity[, c(3:563, 565)]
group_subj_act <- group_by(subset_subj_act, subj_act)
by_subj_act <- summarise_each(group_subj_act, funs(mean))
write.table(by_subj_act, "./data/by_subj_act.txt", row.names = F)