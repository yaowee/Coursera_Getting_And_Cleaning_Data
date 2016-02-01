#Smartphone Data Set CodeBook
This CodeBook provides further explanation about the data set. Specifically, how the raw data sets for training and test is transformed into a final combined tidy data required by the project. The CodeBook consist of 4 sections that details the following:

1. The original features selected in the raw data sets.
2. The features extracted from the raw data sets to create a combined data set.
3. Naming convention and changes to the features extracted from the raw data sets.
4. The naming convention and information about the features in the final tidy data set.

##1. Original Feature Selection
The features selected for th raw data set come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in https://github.com/yaowee/Coursera_Getting_And_Cleaning_Data/blob/master/features.txt

##2. Features Extracted

The features extracted from the raw data sets are only the measurements on the mean and standard deviation for each measurement. As required by the project requirements, any columns with the name that contains only "std()" or "mean()" were extracted into a combined data set of training and test. For instance, "tBodyAcc-mean()-Z" and "tBodyGyro-std()-Y" are examples of features that are extracted from the raw data set. A total of **68** features were extracted from the raw data set using the criteria including the subject Id, which identifies a subject performing an activity, and the name of the activity the subject performed such as STANDING, WALKING, etc.

The complete list of variables of each feature extracted is available in https://github.com/yaowee/Coursera_Getting_And_Cleaning_Data/blob/master/features_extracted.txt

The "ColumnNum" column represents the column index of each feature extracted, where the value "1" represents the first column.

##3. Feature Column Naming Convention & Changes After Combining Raw Train and Test Data Set

In order to make data variable names more descriptive and easier to understand, several column naming convention were used to change the name of the columns of the features extracted in section 2. 

Specifically, after **combining the raw training and test data sets** into a data frame with 10,299 rows and 68 columns, the following name transformation rules were used to rename columns:

1. Replace all column names that start with a 't' with 'Time'

2. Replace all column names that start with a 'f' with 'Freq'

3. Replace all column names with '-mean()' with '.Mean'

4. Replace all column names with '-std()' with '.StdDev'

5. Replace all column names ending with '-X', '-Y', '-Z' with ".Xaxis",".Yaxis",".Zaxis" respectively

**Examples**

Using the rules above, we see the following changes in the original column name

**_Original Column Name -> Transformed Column Name_**

"tBodyAcc-mean()-Z" ->  "TimeBodyAcc.Mean.Zaxis"

"fBodyAcc-std()-X" -> "FreqBodyAcc.StdDev.Xaxis"

##4. Tidy Data Set Data Columns & Convention

Once the raw training and test data sets are combined, an independent tidy data set is created by summarising each subject Id and activity name into the average of all the other variables. The tidy data set contains 180 rows and 68 columns. 

A further column name transformation is used to indicate that the variables, other than SubjectId and ActivityName columns, are average of mean and standard deviation of measurements: 

1. Rename each column name by appending "Avg." in front of each column name to indicate that the variables are average of mean and standard deviation of measurements.

**Examples**

Using the rules above, we see the following changes in the original column name

**_Original Column Name -> Transformed Column Name_**

"TimeBodyAcc.Mean.Zaxis" -> "Avg.TimeBodyAcc.Mean.Zaxis"

"FreqBodyAcc.StdDev.Xaxis" -> "Avg.FreqBodyAcc.StdDev.Xaxis"

The final tidy data set after the column name changes contains 180 rows and 68 variables.

The final tidy data set can be seen in https://github.com/yaowee/Coursera_Getting_And_Cleaning_Data/blob/master/tidy_Smartphone_DataSet.txt
