library(data.table)

path = getwd()

#Download the zip file and extracts it into the working directory.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "Dataset.zip"))
unzip(zipfile = "Dataset.zip")

#Getting Data from the files.
features <- fread(file.path(path,"UCI HAR Dataset/features.txt"),col.names = c("SNO","Features"))

activelabels <- fread(file.path(path,"UCI HAR Dataset/activity_labels.txt"),col.names = c("SNO","Activity"))

#Extracts only the measurements on the mean and standard deviation 
#for each measurement.
listfeatures <- grep("(mean|std)",features[,Features])

featurenames <- toupper(gsub("[()]","",features[listfeatures,Features]))

traindataset <- data.table::fread(file.path(path,"UCI HAR Dataset/train/X_train.txt"))[,listfeatures,with = FALSE]
data.table::setnames(traindataset,featurenames)
trainactivity <- data.table::fread(file.path(path,"UCI HAR Dataset/train/Y_train.txt"),col.names = "Activity")
trainsubject <- fread(file.path(path,"UCI HAR Dataset/train/subject_train.txt"),col.names = "Subject")
train <- cbind(trainsubject,trainactivity,traindataset)

testdataset <- data.table::fread(file.path(path,"UCI HAR Dataset/test/X_test.txt"))[,listfeatures,with = FALSE]
data.table::setnames(testdataset,featurenames)
testactivity <- data.table::fread(file.path(path,"UCI HAR Dataset/test/Y_test.txt"),col.names = "Activity")
testsubject <- fread(file.path(path,"UCI HAR Dataset/test/subject_test.txt"),col.names = "Subject")
test <- cbind(testsubject,testactivity,testdataset)

#Merges the training and the test sets to create one data set.
MergedData <- rbind(train,test)

#Descriptive activity names to name the activities in the data set.
MergedData$Activity = activelabels[MergedData$Activity,2]

#Appropriately labels the data set with descriptive variable names.
names(MergedData)<-gsub("^T", "Time", names(MergedData))
names(MergedData)<-gsub("BODY", "Body", names(MergedData))
names(MergedData)<-gsub("ACC", "Accelerometer", names(MergedData))
names(MergedData)<-gsub("JERK", "Jerk", names(MergedData))
names(MergedData)<-gsub("-MEAN()", "Mean", names(MergedData))
names(MergedData)<-gsub("-STD()", "STD", names(MergedData))
names(MergedData)<-gsub("GRAVITY", "Gravity", names(MergedData))
names(MergedData)<-gsub("GYRO", "Gyroscope", names(MergedData))
names(MergedData)<-gsub("MAG", "Magnitude", names(MergedData))
names(MergedData)<-gsub("^F", "Frequency", names(MergedData))
names(MergedData)<-gsub("-FREQ()", "Frequency", names(MergedData))
names(MergedData)<-gsub("ANGLE", "Angle", names(MergedData))
names(MergedData)<-gsub("Timeimeime", "Time", names(MergedData))
names(MergedData)<-gsub("Frequencyrequencyrequency", "Frequency", names(MergedData))
names(MergedData)<-gsub("BodyBody", "Body", names(MergedData))
names(MergedData)<-gsub("Frequencyrequency", "Frequency", names(MergedData))

#Tidy data set with the average of each variable for each 
#activity and each subject.
FinalData<-aggregate(. ~Subject + Activity, MergedData, mean)
FinalData<-FinalData[order(FinalData$Subject,FinalData$Activity),]
write.table(FinalData,"TidyData.txt",row.names = FALSE,quote = FALSE)

