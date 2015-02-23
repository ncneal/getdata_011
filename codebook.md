README
======	

Packages used
-------------
The 'dplyr' library is loaded for later use.


Data
----
The code downloads a zip file from the url below into the current working directory and un zips the files.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The code downloads this data and unzips the file into the current working directory.

The variables used in the download section of the code
* destFile - download destination file names
* dataURL - the url where the zip file was downloaded

The data is accelerometer and gyroscope data from an experiment on human activity. There are two groups in the experiment, a 'test' group and 'training' group.

This data has several data files, all being space delimited text files. The files relevant for this project:

Test Group Data
* test/X_test.txt - data containing 561 variables for the 'test' group
 * test/y_test.txt - the activity for each observatoin in the data contained in X_test.txt
 * test/subject_test.txt - the subject for each observation in the data contained in X_test.txt

Training Group Data
* train/X_train.txt - data containing 561 variables for the 'training' group
 * test/y_train.txt - the activity for each observatoin in the data contained in X_train.txt
 * test/subject_train.txt - the subject for each observation in the data contained in X_train.txt

Variable Descriptions
*activity_labels.txt - descriptions for the variables contained in y_test.txt and y_train.txt
*features.txt - descriptions for the variables contained in X_test.txt and X_train.txt


Code
----
#### Open files

Data is read from the data files above into data frames below and column names are added for a few files:

* stest <- subject_test.txt
 * 'subject' column name is added to only column in file
* xtest <- X_test.txt
* ytest <- y_test.txt
 * 'activityId column is added to only column in file
* strain <- subject_train.txt
 * 'subject' column name is added to only column in file
* xtest <- X_train.txt
* ytest <- y_train.txt
 * 'activityId column is added to only column in file
* features <- features.txt
* activity <- activity_labels.txt
 * 'activityId' column name is added to the first column
** 'activityDesc' column name is added to the second column

#### Add variable names to variables data sets
Column names are added to the 'xtest' and 'xtrain' data frames using the second column in the 'features' data frame.

#### Create list of variables we are interested in
A list of variables we are interested are created using the 'features' data frame by filtering the second column 
where the string contains 'mean' OR 'std' to get only mean and standard deviation variables.

* cols - the variable we assing this list to

#### Select'xtest' and 'xtrain' data frames and add 'dataset' variable 
Columns that are not contained in the 'cols' object are removed from 'xtest' and 'xtrain' data sets 
and a varable is added to 'xtest' and 'xtrain' data sets so we know which data set the observation came from 
when we combine them into one table.

* dataset - column added to 'xtest' and 'xtrain'


#### Combine all data sets 
* 'xtest', 'ytest', and 'stest' are combined by a column bind and assigned to a new data frame 'test'
* 'xtrain', 'ytrain', and 'strain' are combined by a column bind and assigned to a new data frame 'train'
* the resulting data frames, 'test' and 'train' are combined and assigned to a new data frame 'data'

#### Add activity descriptions
Activity descriptions are added as a new column by merging the 'data' and 'activity' data frames and assigned to a 
new data frame 'datafinal'

#### Group and summarize final data
All columns except the 'dataset' and 'activityId' columns are selected from the 'datafinal' data frame, resuling selection
is grouped by the 'activityDesc' and 'subject' columns and the data is summarized by the mean of all the remaining columns
and assigned assigned to a new data frame 'groupavg'


#### Output txt file
The 'groupavg' data frame is exported as a space delimited text file into the same folder as our original data.