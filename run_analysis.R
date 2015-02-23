#load necessary libraries
library("dplyr")

#set download file name
destFile <- "UCI_HAR_Dataset.zip"
#set download url locations
dataURL <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
#download file
download.file(dataURL, destFile)
#unzip dataset download
unzip("UCI_HAR_Dataset.zip")

#Open files
stest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names ="subject")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityId")
strain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityId")
features <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityDesc"))

#add variable names to variables data sets
colnames(xtest) <- features[,2]
colnames(xtrain) <- features[,2]

#create list of variables we are interested in
cols <- grep(("mean|std"), features[,2])

#filter data sets on columns we are interested in and add varable 
#to data sets so we know which data set the observation came from 
#when we combine into one table
xtest <- mutate(xtest[,cols], dataset = "test")
xtrain <- mutate(xtrain[,cols], dataset = "train")
        
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


