The script is explained with the comments on the code, repeated below.
It basically takes the train and test datasets, rbind them together and them group this dataset by 
a new variable created by the combination of subject and activity variables (180 unique values).
the output is a tidy dataset called 'by_subj_act.txt', with 180 rows and 562 columns:
        - The first variable is subj_act (just explained)
        - The other 561 variables are the average of each feature collected by the Samsung S

## Loads the data into R, giving appropriate names for the variables
## - 'features.txt': List of all 561 features with their names (561 variables)
## - 'activity_labels.txt': Links the class labels with their activity name (6 activities)

## train tables: 7352 records

## - 'train/X_train.txt': training set. 561 variables
## - 'train/y_train.txt': training labels (labels from activity_labels.txt). 1 variable.
## - 'train/subject_train.txt': Each row identifies the subject who performed the activity for 
## each window sample. Its range is from 1 to 30. 1 variable.
## Sets the name of the variables for these datasets

## test tables: 2947 records

## - 'test/X_test.txt': test set. 561 variables
## - 'test/y_test.txt': test labels (labels from activity_labels.txt). 1 variable.
## - 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. ## Its range is from 1 to 30. 1 variable.

## Merges train tables together

## Merges test tables together

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. - Done
## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.

## Creates a new variable subject/ activity
## Gets the average for each subject/ activity