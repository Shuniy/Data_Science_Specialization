#Loading Dataset mtcars.
library(datasets)
data("mtcars")

#Summarizing data.
head(mtcars)
str(mtcars)
summary(mtcars$mpg)

#Making am variable a factor variable which contains transmission data.
mtcars$am <- as.factor(as.numeric(mtcars$am))

#Plotting Boxplot to compare the mpg by type of transmission. 
plot1 <- ggplot(data = mtcars, aes(x = am, y = mpg, fill = am)) + 
         geom_boxplot() + xlab("Types of Transmission(0 - Automatic, 1- Mannual)") +
         ylab("Miles/(US) Gallon") + ggtitle("Relation b/w Transmission and Mpg")

plot1

#Splitting data according to type of transmission
MotorTrend <- split.data.frame(mtcars, mtcars$am)

#Range of the mpg with different transmission.
range(MotorTrend$`0`$mpg)
range(MotorTrend$`1`$mpg)

#Mean of the mpg with different transmission.
mean(MotorTrend$`0`$mpg)
mean(MotorTrend$`1`$mpg)

#Standard Deviation of the mpg with different transmission.
sd(MotorTrend$`0`$mpg)
sd(MotorTrend$`1`$mpg)

#Variance of the mpg with different transmission.
var(MotorTrend$`0`$mpg)
var(MotorTrend$`1`$mpg)

#Performing t.test on data.
t.test(MotorTrend$`0`$mpg, MotorTrend$`1`$mpg)

#Regression
fit <- lm(mpg ~ factor(am), mtcars)
summary(fit)

fit2 <- lm(mpg  ~ . , mtcars)
summary(fit2)

fit3 <- lm(mpg ~ cyl + disp + wt + am, data = mtcars)
summary(fit3)

#Performing anova
anova(fit, fit2)

#Plotting graphs to compare 
par(mar = c(4,4,2,2), mfrow = c(2,2))
plot(fit3)
par(mar = c(1,1,1,1))
pairs(mpg ~., mtcars)
