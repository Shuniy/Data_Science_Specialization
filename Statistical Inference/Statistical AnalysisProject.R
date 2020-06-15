library(datasets)
library(ggplot2)
library(dplyr)

#Setting Seed
set.seed(1)

#Setting lambda to 0.2
lambda <- 0.2

#We need 40 Exponents
n <- 40

#1000 Simulations
simulations <- 1000

# Creating 1000 simulations with 40 exponential values.
Exponentials <- replicate(simulations, rexp(n, rate = lambda))

# Calculate mean of 1000 Samples with 40 Exponentials
ExponentialsMean <- apply(Exponentials, 2, mean)

#Analytical Mean of the data.
AnalyticalMean <- mean(ExponentialsMean)
AnalyticalMean

#Theoritical Mean of the data.
TheoryMean <- 1/lambda
TheoryMean

#Histogram of Means.
hist(ExponentialsMean, xlab = "mean", main = "Exponential Simulations")
abline(v = AnalyticalMean, col = "red")
abline(v = TheoryMean, col = "blue")

#Standard Deviation of distribution.
StandardDeviation <- sd(ExponentialsMean)
StandardDeviation

#Analytical Standard deviation
TheoryStandardDeviation <- (1/lambda)/sqrt(n)
TheoryStandardDeviation

#Variance of distribution
Variance <- StandardDeviation^2
Variance

#Analytical Variance.
TheoryVariance <- ((1/lambda)*(1/sqrt(n)))^2
TheoryVariance

#Plot to show distribution is normal.
X <- seq(min(ExponentialsMean), max(ExponentialsMean), length.out = 200)
Y <- dnorm(X, mean = TheoryMean, sd = TheoryStandardDeviation)
hist(ExponentialsMean, breaks = n, prob = TRUE, col = "wheat", xlab = "Means", 
     main="Density of Means", ylab="Density")
lines(X, Y, col="black", lty=1)
abline(v = TheoryMean, col = "red")

#Confidence intervals by Analysis
TheoryCI<- TheoryMean + c(-1,1) * 1.96 * TheoryStandardDeviation/sqrt(n)
TheoryCI

#Actual Confidence intervals
ActualCI<- AnalyticalMean + c(-1,1) * 1.96 * StandardDeviation/sqrt(n)
ActualCI

#####################################################################################################################################################
#Basic Inferential Data Analysis Instructions

data("ToothGrowth")

dim(ToothGrowth)

summary(ToothGrowth)

qplot(x = supp, y = len, data = ToothGrowth, facets = ~ dose, 
      main = "Tooth Growth by Supplement Type and Dosage", xlab="Supplement",
      ylab = "Length of Tooth") + geom_boxplot(aes(fill = supp))

unique(ToothGrowth$dose)

Dose0.5 <- subset.data.frame(x = ToothGrowth, dose == 0.5) 
Dose1.0 <- subset.data.frame(x = ToothGrowth, dose == 1.0) 
Dose2.0 <- subset.data.frame(x = ToothGrowth, dose == 2.0) 


#T.test on the data with 0.5 dose
T.TestDose0.5 <- t.test(len ~ supp, data = Dose0.5)
T.TestDose0.5

#T.test on the data with 1.0 dose
T.TestDose1.0 <- t.test(len ~ supp, data = Dose1.0)
T.TestDose1.0

#T.test on the data with 2.0 dose
T.TestDose2.0 <- t.test(len ~ supp, data = Dose2.0)
T.TestDose2.0

#T.test on the ToothGrowth data
T.TestToothGrowth <- t.test(len ~ supp, data = ToothGrowth)
T.TestToothGrowth
