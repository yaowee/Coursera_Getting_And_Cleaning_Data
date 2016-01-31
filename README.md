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

**_Step 1: Checks data set in current directory._**

1.1. Checks if data set exist in the current directory.

1.2. If data set does not exist, download the data set required and unzips it to the current directory the script is in.

**_Step 2:  Merges the training and the test sets with feature names, activity names and subject Ids to create one data set._**

**NOTE: Step 2 achieves 3.1 and 3.3 mentioned in section 3.**

2.1 Extract feature names from **_features.txt_**.

2.2 Read training set into memory from  **_train/X_train.txt_**.

2.3 Name columns of training set with feature names extracted.

2.4 Extract training set activity label and activity names from **_train/y_train.txt_** and **_activity_labels.txt_**.

2.5 Create a table that maps each observation's activity label in the training set to corresponding name of the activity.

2.6 Extract each observation's subject's Id from **_train/subject_train.txt_**.

2.7 Merge the data extracted from **2.2**,**2.5**,**2.6** by binding the columns of the 3 data sets together.

2.8 Repeat **steps 2.2 to 2.7** to get a combined data set for the test data found in the directory **_test/_**

2.9 Create a merged data frame of both training and test set by appending the test set data after the training set. At this point, **section 3.1 and 3.3** has been achieved

**_Step 3: Extracts only measurements on the mean and standard deviation for each measurement_**

**NOTE: Step 3 achieves 3.2 mentioned in section 3.**

3.1 Extract variables in the data frame from step 2 that are mean and standard deviation of each measurement using regular expression along with the columns that contain observation subject Ids and activity names into a new data frame

**NOTE: For details of what columns were extracted please goto:** https://github.com/yaowee/Coursera_Getting_And_Cleaning_Data/blob/master/CodeBook.md#2-features-extracted

**_Step 4: Renaming the data set with descriptive variable names._**

**NOTE: Step 4 achieves 3.4 mentioned in section 3.**

Using data frame from step 3,

4.1 Replace all column names that start with a 't' with 'Time'

4.2 Replace all column names that start with a 'f' with 'Freq'

4.3 Replace all column names with '-mean()' with '.Mean'

4.4 Replace all column names with '-std()' with '.StdDev'

4.5 Replace all column names ending with '-X', '-Y', '-Z' with ".Xaxis",".Yaxis",".Zaxis" respectively

**NOTE: For details of what transformation were made to the column names please goto:** https://github.com/yaowee/Coursera_Getting_And_Cleaning_Data/blob/master/CodeBook.md#3-feature-column-naming-convention--changes

**Step 5: Create and output a second, independent tidy data set with the average of each variable for each activity and each subject**

**NOTE: Step 5 achieves 3.5 mentioned in section 3.**

Using data frame from step 4,

5.1 Create a data set that contains the average of each variable for each activity and each subject using **dplyr** package

5.2 Rename the variables' column names to reflect that each variable is average for each activity and each subject

5.3 Writes tidy data set to file without row names

**NOTE: For details of the data columns and conventions used in the tidy data set, please goto:** https://github.com/yaowee/Coursera_Getting_And_Cleaning_Data/blob/master/CodeBook.md#4-tidy-data-set-data-columns--convention
