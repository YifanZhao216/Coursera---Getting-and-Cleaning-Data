#set work directory
setwd('/Users/zhaoyifan/Desktop/Coursera R/Coursera Cleaning and Getting Data/Final Project')

#download zip file from the website
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileURL, destfile = '/Users/zhaoyifan/Desktop/Coursera R/Coursera Cleaning and Getting Data/Final Project/data.zip', method = 'curl')

#unzip data
data <- unzip('data.zip', exdir = '/Users/zhaoyifan/Desktop/Coursera R/Coursera Cleaning and Getting Data/Final Project/data')

#read data into R
trainx <- read.table('data/UCI HAR Dataset/train/X_train.txt')
trainy <- read.table('data/UCI HAR Dataset/train/y_train.txt')
trainsubject <- read.table('data/UCI HAR Dataset/train/subject_train.txt')
testx <- read.table('data/UCI HAR Dataset/test/X_test.txt')
testy <- read.table('data/UCI HAR Dataset/test/y_test.txt')
testsubject <- read.table('data/UCI HAR Dataset/test/subject_test.txt')

### 1. Merges the training and the test sets to create one data set ###
train <- cbind(trainsubject, trainy, trainx)
test <- cbind(testsubject, testy, testx)
dataset <- rbind(train, test)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement ###
#load feature into R
feature <- read.table('data/UCI HAR Dataset/features.txt', stringsAsFactors = FALSE)[, 2]

#extract index of mean and standard deviation
measure <- grep(('mean\\(\\)|std\\(\\)'), feature)

#subset the data with the index
finaldata <- dataset[, c(1, 2, measure)]

#rename the columns with the feature name
colnames(finaldata) <- c("subject", "activity", feature[measure])

### 3. Uses descriptive activity names to name the activities in the data set ###

#load activity data into R
activity <- read.table('data/UCI HAR Dataset/activity_labels.txt')

#replace 1 to 6 with activity names
finaldata$activity <- factor(finaldata$activity, levels = activity[, 1], labels = activity[, 2])

### 4. Appropriately labels the data set with descriptive variable names ###
names(finaldata) <- gsub('\\()', '', names(finaldata))
names(finaldata) <- gsub('^t', 'time.', names(finaldata))
names(finaldata) <- gsub('^f', 'frequency.', names(finaldata))
names(finaldata) <- gsub('-mean', '.mean', names(finaldata))
names(finaldata) <- gsub('-std', '.std', names(finaldata))

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject ###
library(dplyr)
group <- finaldata %>% group_by(subject, activity) %>% summarise_each(funs(mean))

write.table(group, 'Data/Data.txt', row.names = FALSE)
