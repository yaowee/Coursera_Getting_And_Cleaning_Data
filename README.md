# Getting And Cleaning Data Project

##1.Purpose of project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

##2.Context of Data Set
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data used in this project contains data collected from the accelerometers from the Samsung Galaxy S smartphone. The data set along with the full description of the data was obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##3.Project Requirements & Deliverables

Deliverable for this project is an R script called **_run_analysis.R_** that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##4.How **_run_analysis.R_** script works

**_run_analysis.R_** script in this repository fulfills all requirements and deliverables mentioned in **section 3** in 5 steps.

**NOTE:** **_run_analysis.R_** uses the **dplyr** package. Please install the package prior to running the script.

The steps in the script as executed in the following order:

**Step 1: Checks data set in current directory.**

1.1 Checks if data set exist in the current directory.

1.2 If data set does not exist, download the data set required and unzips it to the current directory the script is in.

**Step 2:  Merges the training and the test sets with feature names, activity names and subject Ids to create one data set.**

**NOTE: Step 2 achieves 3.1 and 3.3 mentioned in section 3.**

2.1 Extract feature names from **_features.txt_**.

2.2 Read training set into memory from  **_train/X_train.txt_**.

2.3 Name columns of training set with feature names extracted.

2.4 Extract training set activity label and activity names from **_train/y_train.txt_** and **_activity_labels.txt_**.

2.5 Create a table that maps each observation's activity label in the training set to corresponding name of the activity.

2.6 Extract each observation's subject's Id from **_train/subject_train.txt_**.

2.7 Merge the data extracted from **2.2**,**2.5**,**2.6** by binding the columns of the 3 data sets together.

2.8 Repeat **steps 2.2 to 2.7** to get a combined data set for the test data found in the directory **_test/_**

2.9 Create a merged the training and test set by appending the test set data after the training set
