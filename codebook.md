See an explanation of each part of the script below. The comments in the code correspond to the
heading below and a further explanation is given for each.

`#load necessary libraries`  
loads the **dplyr** library

`#set download file name`  
assigns the file name to `destFile`

`#set download url locations`  
assigns the URL for the zip file to be downloaded to `dataURL`

`#download file`  
downloads the zip file

`#unzip dataset download`  
unzips the downloaded file to the working directory

`#Open files`  
reads all necessary text files into data frames
* `x*` data frames are the variables
* `y*` data frames are the activities
* `s*` data frames are the subjects
* `features` data frame containes variable names
* `activity` data frame contatins the activity descriptions 

`#add variable names to variables data sets`  
adds column names to the two `x*` data frames using the `features` data frame as names

`#create list of variables we are interested in`  
create a list of variable names we want to use by filtering the features data frame

```
#filter data sets on columns we are interested in and add varable 
#to data sets so we know which data set the observation came from 
#when we combine into one table
```
over write the existing `x*` data frames and adds a variable to each to identify 
which data set they came from in case we want to split out once we combine the two
```        
#combine test and train data sets into two data sets only including columns
#we are interested in from the variable data
```
* column bind `stest`, `ytest`, `xtest` and assing to `test` data frame
* column bind `strain`, `ytrain`, `xtrain` and assign to `train` data frame
* row bind the `test` and `train` data frames and assign to the `data` data frame

`#add activity descriptions`  
merge the `data` and `activity` data frames to add the `activityDesc` column and assing to `datafinal` data frame

`#group and find mean of each variable and assing to new table`  
Perform the following and assign to `groupavg` data frame:
* select `datafinal` data frame excluding `dataset` and `activityId` columns
* group by `activityDesc` and `subject`
* summarize the remaining columns by mean

`#output average table to 'subjectActivityAvg.txt'`  
export the `groupavg` data frame to the directory in which the original data was contained


