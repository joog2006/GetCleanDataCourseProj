#Run_analysis script for Getting and Cleaning Data course project
#include libraries

library(dplyr)

#Assume data has been unzipped to working directory

#Read train folder
trainLoc <- "~/R/GCdata/train"
filenames <- list.files(path=trainLoc, pattern="*.txt")

#Assign each file to a dataframe with the same name as the file. Use paste to append path to file name
for (i in seq_along(filenames)) {
  assign(substr(filenames[i], 1, nchar(filenames[i])-4), read.table(paste(trainLoc, filenames[i], sep="/")))
}

#Read test folder
testLoc <- "~/R/GCdata/test"
filenames <- list.files(path=testLoc, pattern="*.txt")

for (i in seq_along(filenames)) {
  assign(substr(filenames[i], 1, nchar(filenames[i])-4), read.table(paste(testLoc, filenames[i], sep="/")))
}

#Read main folder data
features <- read.table("features.txt", colClasses = c("character"))
activity_labels <- read.table("activity_labels.txt", col.names = c("ActivityId", "ActivityName"))

#Merge training and test data into 2 sets
training <- cbind(X_train, subject_train)
training <- cbind(training, y_train)
test <- cbind(X_test, subject_test)
test <- cbind(test, y_test)
AllData <- rbind(training, test)

#Merge features in as column names
names(AllData) <- features$V2
colnames(AllData)[562] <- "SubjectID"
colnames(AllData)[563] <- "ActivityID"

#Select the columns with mean, std, and ids
AllDataStats <- AllData[,grepl("mean", names(AllData))|
                         grepl("std", names(AllData))|
                         grepl("SubjectID", names(AllData))|
                         grepl("ActivityID", names(AllData))
                        ]
#Merge Activity Names by AcitivityID, standardize merge variable name
colnames(activity_labels)[1] <- "ActivityID"
AllDataLabeled <- inner_join(AllDataStats, activity_labels)

#clean Variable Names
##Remove double paranthesis
names(AllDataLabeled) <- gsub("\\()","",names(AllDataLabeled))

##more descriptive
names(AllDataLabeled) <- gsub("fBody","FreqBody",names(AllDataLabeled))
names(AllDataLabeled) <- gsub("tBody","TimeBody",names(AllDataLabeled))
names(AllDataLabeled) <- gsub("tGrav","TimeGrav",names(AllDataLabeled))
names(AllDataLabeled) <- gsub("-","_",names(AllDataLabeled))
names(AllDataLabeled) <- gsub(",",".",names(AllDataLabeled))

#Export Tidy Data
write.table(AllDataLabeled, file="TidyData.txt")

#Sum Data by subject and activityName
AllDataGrouped <- group_by(AllDataLabeled, ActivityName, SubjectID)

#Load plyr to summarize over all columns
library(plyr)
FinalSums <- ddply(AllDataGrouped, .(ActivityName, SubjectID), numcolwise(mean))