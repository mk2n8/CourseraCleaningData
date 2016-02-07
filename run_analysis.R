#       GETTING AND CLEANING DATA COURSE PROJECT

##      Creating a directory
if (!file.exists("wearables data")) {
        dir.create ("wearables data")
}

##      Retrieving and unzipping the data

library(downloader)

download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
         dest="wearables data/wearables.zip", 
         mode="wb")
list.files("./wearables data")
unzip("./wearables data/wearables.zip", exdir = "./wearables data")
file.remove("./wearables data/wearables.zip")

#Step 1: "Merges the training and the test sets to create one data set."
# read subject training data
subject_train = read.table("./wearables data/UCI HAR Dataset/train/subject_train.txt", col.names=c("subject_id"))
# assign row number as the values of ID column
subject_train$ID <- as.numeric(rownames(subject_train))
# read training data
X_train = read.table("./wearables data/UCI HAR Dataset/train/X_train.txt")
# assign row number as the values of ID column
X_train$ID <- as.numeric(rownames(X_train))
# read activity training data
y_train = read.table("./wearables data/UCI HAR Dataset/train/y_train.txt", col.names=c("activity_id"))
# assign row number as the values of ID column
y_train$ID <- as.numeric(rownames(y_train))
# merge subject_train and y_train to train
train <- merge(subject_train, y_train, all=TRUE)
# merge train and X_train
train <- merge(train, X_train, all=TRUE)

# read subject training data
subject_test = read.table("wearables data/UCI HAR Dataset/test/subject_test.txt", col.names=c("subject_id"))
# assign row number as the values of ID column
subject_test$ID <- as.numeric(rownames(subject_test))
# read testing data
X_test = read.table("wearables data/UCI HAR Dataset/test/X_test.txt")
# assign row number as the values of ID column
X_test$ID <- as.numeric(rownames(X_test))
# read activity testing data
y_test = read.table("wearables data/UCI HAR Dataset/test/y_test.txt", col.names=c("activity_id"))  
# assign row number as the values of ID column
y_test$ID <- as.numeric(rownames(y_test))
# merge subject_test and y_test to train
test <- merge(subject_test, y_test, all=TRUE) 
# merge test and X_test
test <- merge(test, X_test, all=TRUE) 

#combine train and test
data1 <- rbind(train, test)

#save out tidy data as .txt
write.table(data1, file = "./wearables data/TidyData.txt", row.name = FALSE)
