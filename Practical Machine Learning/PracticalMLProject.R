#Loading libraries.
library(caret)
library(reshape2)
library(rpart)
library(rpart.plot)
library(dplyr)
library(rattle)
library(randomForest)
library(gbm)
library(corrplot)
set.seed(12345)

#Loading datasets from website.
#TrainData is training data and TestData is validation data.
TrainData <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
TestData  <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")

#Removing NA values from Train and Validation Data.
TrainData <- TrainData[, colSums(is.na(TrainData))==0]
TestData <- TestData[, colSums(is.na(TestData))==0]

#Changing class of cvtd_timestamp variable from factor to Date time format. 
TrainData$cvtd_timestamp <- as.Date(TrainData$cvtd_timestamp, format = "%m/%d/%Y %H:%M")
#Adding Days variable which gives weekday at that time.
TrainData$Days <- factor(weekdays(TrainData$cvtd_timestamp))

#Proportion Table and Summary of activities.
table(TrainData$classe)
prop.table(table(TrainData$classe))
prop.table(table(TrainData$user_name))
prop.table(table(TrainData$user_name, TrainData$classe), 1)
prop.table(table(TrainData$user_name, TrainData$classe), 2)
prop.table(table(TrainData$classe, TrainData$Days), 1)
qplot(x = Days, fill = classe, data = TrainData)

#Creating a partition with the training dataset 
inTrain  <- createDataPartition(TrainData$classe, p = 0.70, list = FALSE)
TrainSet <- TrainData[inTrain, ]
TestSet  <- TrainData[-inTrain, ]

#Removing data with zero variance 
#since they are considered to have less predictive power.(STACKEXCHANGE)
ZeroVariance <- nearZeroVar(TrainSet)
TrainSet <- TrainSet[, -ZeroVariance]
TestSet  <- TestSet[, -ZeroVariance]

TrainSet <- TrainSet[,-(1:5)]
TestSet <- TestSet[,-(1:5)]

#Removing columns with NA values. 
NAS <- sapply(TrainSet, function(x) mean(is.na(x))) > 0
TrainSet <- TrainSet[, NAS == FALSE]
TestSet  <- TestSet[, NAS == FALSE]
dim(TrainSet)
dim(TestSet)

#Checking data with high correlation.

Correlation <- cor(TrainData[sapply(TrainData, is.numeric)])
Cor <- findCorrelation(Correlation)

#Correlated data.
names(TrainSet)[Cor]

#Correlation Plot
corrplot(Correlation)

Correlation <- melt(Correlation)
qplot(x = Var1, y = Var2, data = Correlation, fill = value, color = value) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

##From the graph it shows there is a correlation in variables.

#Tree Model
ControlRF <- trainControl(method = "cv", number= 3)
ModelTree <- rpart(classe ~ ., data = TrainSet, method="class")
fancyRpartPlot(ModelTree)

#Prediction with Tree Model
PredictModelTree <- predict(ModelTree, newdata = TestSet, type = "class")
ConfMatTree <- confusionMatrix(PredictModelTree, reference = TestSet$classe)
ConfMatTree

#Random Forest
ControlRF <- trainControl(method="cv", number = 3)
ModelRandForest <- train(classe ~ ., data=TrainSet, method="rf",
                          trControl=ControlRF)
ModelRandForest$finalModel

#Prediction with Random Forest Model.
PredictRandForest <- predict(ModelRandForest, newdata = TestSet)
ConfMatRandForest <- confusionMatrix(PredictRandForest, TestSet$classe)
ConfMatRandForest

#GBR Model 
GBR <- trainControl(method = "repeatedcv", number = 5, repeats = 1)
ModelGBM  <- train(classe ~ ., data = TrainSet, method = "gbm", trControl = GBR
                   , verbose = FALSE)
ModelGBM$finalModel

#Prediction with GBR Model
PredictModelGBM <- predict(ModelGBM, newdata = TestSet)
ConfMatGBM <- confusionMatrix(PredictModelGBM, TestSet$classe)
ConfMatGBM

PredictTest <- predict(ModelRandForest, newdata = TestData)
PredictTest
