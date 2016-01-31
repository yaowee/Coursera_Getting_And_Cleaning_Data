#This script requires package "dplyr" to successfully
#Downloads the data sets required and unzips it to the current directory the script is in.
#file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#file.dest <- "UCI_HAR_Dataset.zip"
#download.file(url=file.url,destfile = file.dest)
#unzip(file.dest,exdir=".")

#Step 1: Merging the training and the test sets with activity to create one data set. By working on the following steps:
#NOTE: Step 1 achieves part 1 and 3 listed in the project document.

#Step 1.1 - Preparing training set for merging with labels, label activity names, 
#feature names and subject ids by reading data files.
#Extract feature names from file
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE, 
                       col.names = c("FeatureColIndex","FeatureName"),
                       stringsAsFactors = FALSE)
featureNames <- features$FeatureName
#Remove features data frame from workspace to save memory as it will no longer be of use after extracting the feature names.
rm(features)

#Read training set file and name columns with extracted feature names
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE )
#Set column names as the names of features extracted in featureNames
colnames(trainSet) <- featureNames

#Extract activity label names and merge with training activity names.
#NOTE: This step creates descriptive activity names to names activities in the data set described in part 3 of project.
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header =FALSE, col.names = c("Label","ActivityName"))
trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names = c("Label"))
#create a new column on trainLabels$ActivityName that contains the corresponding activity name for each activity label
trainLabels$ActivityName <-  activityLabels[match(trainLabels$Label,activityLabels$Label),c("ActivityName")]

#Extract ids of subjects in the training set
trainSubjectsId <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE, col.names = c("SubjectId"))
#Merge subjectIds and activity names columns into training set
trainSet <- cbind(trainSubjectsId, ActivityName = trainLabels[,c("ActivityName")], trainSet)
#Remove unused data.frames trainLabels,trainActivityNames and trainSubjectId after merging all necessary data with training set
rm(trainLabels,trainSubjectsId)

#Step 1.2 - Preparing testset for merging by merging labels, feature names and subject ids by reading data files.
#Read training set file and name columns with extracted feature names
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE )
#Set column names as names of features extracted in featureNames
colnames(testSet) <- featureNames
#Create a data frame that maps train activity labels to train activity names 
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names = c("Label"))
#Create a data frame that maps activity labels to activity names 
#NOTE: This step creates descriptive activity names to names activities in the data set described in part 3 of project.
testLabels$ActivityName <-  activityLabels[match(testLabels$Label,activityLabels$Label),c("ActivityName")]

#Extract ids of subjects in the test set.
testSubjectsId <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE, col.names = c("SubjectId"))
#Merge subjectIds and activity names columns into test set
testSet <- cbind(testSubjectsId, ActivityName = testLabels[,c("ActivityName")], testSet)
#Remove unused data.frames testLabels,testActivityNames and testSubjectId,featureNames,activityLabels 
#after merging all necessary data with test set
rm(testLabels,testSubjectsId,featureNames,activityLabels)

#Step 1.3 - Merge training and testing data set
combinedDataSet <- rbind(trainSet,testSet)
#Remove training and test data after combining the 2 sets of data
rm(trainSet,testSet)

#Step 2: Extract only columns that are mean and standard deviation for each measurement
#NOTE: this step covers part 2 of the project document. Extracts on mean and standard deviation measures
#subset on columns with the following column name matches: SubjectId, ActivityName, std() or mean()
meanStdDataSet <- combinedDataSet[,grepl("SubjectId|ActivityName|(std\\(\\))|(mean\\(\\))",colnames(combinedDataSet))]
#Removes unused combinedDataSet since it is no longer required
#rm(combinedDataSet)

#Step 3: Renaming the data set with descriptive variable names.
#NOTE: this step covers part 4 of the project document.
#3.1 - Replace all column names with a 't' at the beginning with 'Time'
colnames(meanStdDataSet) <- sub("^t","Time",colnames(meanStdDataSet))
#3.2 - Replace all column names with 'f' at the beginning with "Freq"
colnames(meanStdDataSet) <- sub("^f","Freq",colnames(meanStdDataSet))
#3.3 - Replace all column names with '-mean()' with ".Mean"
colnames(meanStdDataSet) <- sub("-mean\\(\\)",".Mean",colnames(meanStdDataSet))
#3.4 - Replace all column names with '-std()' with ".StdDev"
colnames(meanStdDataSet) <- sub("-std\\(\\)",".StdDev",colnames(meanStdDataSet))
#3.5 - Replace all column names ending with '-X', '-Y', '-Z' with ".Xaxis",".Yaxis",".Zaxis" respectively
colnames(meanStdDataSet) <- sub("(-)([XYZ]{1})",".\\2axis",colnames(meanStdDataSet))

#Step 4 - Create a second, independent tidy data set with the average of each variable for each activity and each subject
#NOTE: this step covers part 5 of the project documents
#Assumes that dplyr library has been installed
library(dplyr)
#Data set that contains the average of each variable for each activity and each subject
tidyDataSet <- meanStdDataSet %>% group_by(SubjectId,ActivityName) %>% summarise_each(funs(mean))

#Rename only the variable column names to reflect that each variable is average for each activity and each subject
colnames(tidyDataSet)[-(1:2)] <- paste("Avg",colnames(tidyDataSet)[-(1:2)],sep = ".")
#writes tidy data set to file
write.table(tidyDataSet,"tidy_Smartphone_DataSet.txt",sep="\t",row.names = FALSE)
