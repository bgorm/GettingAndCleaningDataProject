# Getting and Cleaning Data Project
# bgorm 
#
# This script performs the following steps, as detailed below:
# 1. Merges the training and the test sets to create one data set. (data frame: har)
# 2. Extracts only the measurements on the mean and standard deviation for each
# measurement. (data frame: desc_stats)
# 3. Uses descriptive activity names to name the activities in the data set (har)
# 4. Appropriately labels the data set with descriptive variable names. (har)
# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject. (meansData)

require(dplyr)
require(reshape)

# Retrieve Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./dataset.zip", method = "curl")
unzip("dataset.zip")

# Read feature names from text file
varNames <- read.table("./UCI HAR Dataset/features.txt",
                       colClasses = c("integer","character"))
varNames <- varNames$V2

# Remove parentheses in variable names
varNames <- sub("\\(","",varNames)
varNames <- sub("\\)","",varNames)

# Read class labels and label names
classLabelTrain <- read.table("./UCI HAR Dataset/train/y_train.txt",
                               colClasses = c("integer"),
                               col.names = c("classLabel"))

classLabelTest <- read.table("./UCI HAR Dataset/test/y_test.txt",
                              colClasses = c("integer"),
                              col.names = c("classLabel"))

classLabelNames <- read.table("./UCI HAR Dataset/activity_labels.txt",
                         colClasses = c("integer","character"), 
                         col.names = c("classLabel","activityName"))

# Read subject IDs
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                          colClasses = "integer",
                          col.names = "subjectID")

subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                          colClasses = "integer",
                          col.names = "subjectID")

# Read test set and training set data
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt",
                      colClasses = rep("numeric",561),
                      col.names = varNames)

trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                       colClasses = rep("numeric",561),
                       col.names = varNames)

# Add subject IDs, activity labels, and observation type (training or test set)
# as columns in the data frame
testSet <- cbind(testSet, classLabelTest, subjectTest, 
                 data.frame(obsType = factor(rep("test", nrow(testSet)))))
trainSet <- cbind(trainSet, classLabelTrain, subjectTrain, 
                  data.frame(obsType = factor(rep("train", nrow(trainSet)))))

# Combine training and test sets
fullSet <- rbind(testSet,trainSet)

# Merge data frame with activity class names to form full tidy data set
har <- merge(fullSet, classLabelNames)

# Remove excess data for tidiness and memory
remove(testSet,trainSet,fullSet,classLabelTrain,classLabelTest,
       classLabelNames,subjectTest,subjectTrain,fileUrl,varNames)

# Extract mean and sd for each measurement and store as "desc_stats" & write output
desc_stats <- rbind(apply(select(har,-classLabel,-activityName,-subjectID,-obsType),2,mean),
                    apply(select(har,-classLabel,-activityName,-subjectID,-obsType),2,sd))
row.names(desc_stats) <- c("mean","sd")

# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
meansData <- select(har,-activityName,-obsType)
meansData <- melt(meansData, id=c("subjectID","classLabel"))
meansData <- arrange(meansData,subjectID,classLabel)
meansData <- cast(meansData,subjectID + classLabel ~ variable, mean)

# Write data outputs
write.table(har,"HAR_full_tidy_dataset.txt",row.name=FALSE)
write.table(desc_stats,"descriptive_stats.txt")
write.table(meansData,"feature_mean_per_subject.class.txt",row.name=FALSE)
