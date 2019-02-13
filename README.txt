==================================================================
Coursera - Getting and Cleaning Data 
Week 4 project of Yifan Zhao
==================================================================

<Explanation for run_analysis.R script>

1. Set the work directory first and download the zip file from the URL

'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

2. Read the data into R

trainx : original data is 'X_train.txt'

trainy : original data is 'y_train.txt'

trainsubject : original data is 'subject_train.txt'

testx : original data is 'X_test.txt')

testy : original data is 'y_test.txt')

testsubject : original data is 'subject_test.txt')

3. Merge the train data and the test data separately

4. Create the dataset that combines the train data and the test data

5. load feature into R and extract the subset data of mean and standard deviation

6. rename the data with the feature names

7. load activity into R and replace 1 to 6 with activity names

8. Relabel the data according to 'features_info.txt'

9. Creates an independent tidy data set with the average of each variable for each activity and each subject

10. Write the final data into computer directory

======================================

<Explanation for CodeBook.md>

describes the variables, data, and transformations that are performed to clean the original data


