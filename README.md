See an explanation of each part of the script below. The comments in the code correspond to the
heading below and a further explanation is given for each.

### #load necessary libraries
this portion of the code load the **dplyr** library

# set download file name
assigns the file name to **destFile**

#### set download url locations
assigns the URL for the zip file to be downloaded to **dataURL**

# download file
downloads the zip file

# unzip dataset download
unzips the downloaded file to the working directory

# Open files
reads all necessary text files into data frames
* **x*** data frames are the variables
* **y*** data frames are the activities
* **s*** data frames are the subjects
* **features** data frame containes variable names
* **activity** data frame contatins the activity descriptions 

#add variable names to variables data sets
adds column names to the two **x*** data frames using the features' data frame as names

#create list of variables we are interested in
create a list of variable names we want to use by filtering the features data frame

#filter data sets on columns we are interested in and add varable 
#to data sets so we know which data set the observation came from 
#when we combine into one table
over write the existing x* data frames
        
#combine test and train data sets into two data sets only including columns
#we are interested in from the variable data
test <- cbind(stest, ytest, xtest)
train <- cbind(strain, ytrain, xtrain)
data <- rbind(test, train)

#add activity descriptions
datafinal <- merge(data, activity)

#group and find mean of each variable and assing to new table
groupavg <- 
        datafinal %>%
        select(-dataset, -activityId) %>%
        group_by(activityDesc, subject) %>%
        summarise_each(funs(mean))

#output average table to 'subjectActivityAvg.txt'
write.table(groupavg, "./UCI HAR Dataset/subjectActivityAvgs.txt", row.name = FALSE)


