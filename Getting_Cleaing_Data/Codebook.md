#Code book for Coursera Getting and Cleaning Data course project 

The data set that this code book pertains to is located in the TidyData.txt file of this repository. 
See the README.md file of this repository for background information on this data set. 
  
The structure of the data set is described in the Data section, its variables are listed in the Variables section, and the transformations that were carried out to obtain the data set based on the source data are presented in the Transformations section. 
  
Data 
The TidyData.txt data file is a text file, containing space-separated values. 
The first row contains the names of the variables, which are listed and described in the Variables section, and the following rows contain the values of these variables. 
  
Variables 
Each row contains, for a given subject and activity,  81 averaged signal measurements.   

Identifiers  

Subject  : 
Subject identifier, integer, ranges from 1 to 30. 
  
Activity : 
Activity identifier, string with 6 possible values: 
  
WALKING: subject was walking  

WALKING_UPSTAIRS: subject was walking upstairs

WALKING_DOWNSTAIRS: subject was walking downstairs 

SITTING: subject was sitting 

STANDING: subject was standing 

LAYING: subject was laying 

All measurements are floating-point values. 
  
The measurements are classified in two domains: 
Time domain signals and Frequency Domain Signals : 
 
TimeBodyAccelerometerMean-X, 
TimeBodyAccelerometerMean-Y,
TimeBodyAccelerometerMean-Z,  
TimeBodyAccelerometerSTD-X, 
TimeBodyAccelerometerSTD-Y, 
TimeBodyAccelerometerSTD-Z,   
TimeGravityAccelerometerMean-X, 
TimeGravityAccelerometerMean-Y, 
TimeGravityAccelerometerMean-Z,   
TimeGravityAccelerometerSTD-X,
TimeGravityAccelerometerSTD-Y, 
TimeGravityAccelerometerSTD-Z,   
TimeBodyAccelerometerJerkMean-X, 
TimeBodyAccelerometerJerkMean-Y, 
TimeBodyAccelerometerJerkMean-Z,   
TimeBodyAccelerometerJerkSTD-X, 
TimeBodyAccelerometerJerkSTD-Y, 
TimeBodyAccelerometerJerkSTD-Z,   
TimeBodyGyroscopeMean-X,
TimeBodyGyroscopeMean-Y, 
TimeBodyGyroscopeMean-Z,   
TimeBodyGyroscopeSTD-X, 
TimeBodyGyroscopeSTD-Y, 
TimeBodyGyroscopeSTD-Z,   
TimeBodyGyroscopeJerkMean-X, 
TimeBodyGyroscopeJerkMean-Y, 
TimeBodyGyroscopeJerkMean-Z,   
TimeBodyGyroscopeJerkSTD-X, 
TimeBodyGyroscopeJerkSTD-Y, 
TimeBodyGyroscopeJerkSTD-Z,   
TimeBodyAccelerometerMagnitudeMean, 
TimeBodyAccelerometerMagnitudeSTD,  
TimeGravityAccelerometerMagnitudeMean, 
TimeGravityAccelerometerMagnitudeSTD,   
TimeBodyAccelerometerJerkMagnitudeMean, 
TimeBodyAccelerometerJerkMagnitudeSTD,   
TimeBodyGyroscopeMagnitudeMean, 
TimeBodyGyroscopeMagnitudeSTD,   
TimeBodyGyroscopeJerkMagnitudeMean, 
TimeBodyGyroscopeJerkMagnitudeSTD,   
FrequencyBodyAccelerometerMean-X, 
FrequencyBodyAccelerometerMean-Y, 
FrequencyBodyAccelerometerMean-Z,   
FrequencyBodyAccelerometerSTD-X, 
FrequencyBodyAccelerometerSTD-Y, 
FrequencyBodyAccelerometerSTD-Z,   
FrequencyBodyAccelerometerMeanFrequency-X, 
FrequencyBodyAccelerometerMeanFrequency-Y, 
FrequencyBodyAccelerometerMeanFrequency-Z,   
FrequencyBodyAccelerometerJerkMean-X, 
FrequencyBodyAccelerometerJerkMean-Y, 
FrequencyBodyAccelerometerJerkMean-Z,   
FrequencyBodyAccelerometerJerkSTD-X, 
FrequencyBodyAccelerometerJerkSTD-Y, 
FrequencyBodyAccelerometerJerkSTD-Z,   
FrequencyBodyAccelerometerJerkMeanFrequency-X, 
FrequencyBodyAccelerometerJerkMeanFrequency-Y, 
FrequencyBodyAccelerometerJerkMeanFrequency-Z,   
FrequencyBodyGyroscopeMean-X, 
FrequencyBodyGyroscopeMean-Y, 
FrequencyBodyGyroscopeMean-Z,  
FrequencyBodyGyroscopeSTD-X, 
FrequencyBodyGyroscopeSTD-Y, 
FrequencyBodyGyroscopeSTD-Z,   
FrequencyBodyGyroscopeMeanFrequency-X, 
FrequencyBodyGyroscopeMeanFrequency-Y, 
FrequencyBodyGyroscopeMeanFrequency-Z,   
FrequencyBodyAccelerometerMagnitudeMean, 
FrequencyBodyAccelerometerMagnitudeSTD, 
FrequencyBodyAccelerometerMagnitudeMeanFrequency,   
FrequencyBodyAccelerometerJerkMagnitudeMean, 
FrequencyBodyAccelerometerJerkMagnitudeSTD, 
FrequencyBodyAccelerometerJerkMagnitudeMeanFrequency,   
FrequencyBodyGyroscopeMagnitudeMean, 
FrequencyBodyGyroscopeMagnitudeSTD, 
FrequencyBodyGyroscopeMagnitudeMeanFrequency,   
FrequencyBodyGyroscopeJerkMagnitudeMean, 
FrequencyBodyGyroscopeJerkMagnitudeSTD, 
FrequencyBodyGyroscopeJerkMagnitudeMeanFrequency 

Transformations 
The zip file containing the source data is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
  
The following transformations were applied to the source data: 
  
The training and test sets were merged to create one data set. 
The measurements on the mean and standard deviation (i.e. signals containing the strings mean and std) were extracted for each measurement, and the others were discarded. 
The activity identifiers (originally coded as integers between 1 and 6) were replaced with descriptive activity names (see Identifiers section). 
The variable names were replaced with descriptive variable names (e.g. tBodyAcc-mean()-X was expanded to TimeBodyAccelerometerMean-X), using the following set of rules: 
Special characters (i.e. “()”) were removed 
The initial f and t were expanded to Frequency and Time respectively. 
Acc, Gyro, Mag, Freq, mean, and std were replaced with Accelerometer, Gyroscope, Magnitude, Frequency, Mean, and STD respectively. 
Replaced BodyBody with Body. 
From the data set in step 4, the final data set was created with the average of each variable for each activity and each subject. 
The collection of the source data and the transformations listed above were implemented by the run_analysis.R script (see README.md file for usage instructions). 

