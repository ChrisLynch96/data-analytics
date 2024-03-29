library("partykit")
library("rpart")
library("party")

rm(list=ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab4")

Data <- read.csv("RT.csv", header=TRUE, sep=";")
Data
attach(Data)
RTModel <- rpart(Weight ~ Height, method="anova", 
                 control=rpart.control(minsplit=5, minbucket=2, maxdepth=4))
Fig1 <- plot(as.party(RTModel)) 
print(RTModel)
summary(RTModel)
rsq.rpart(RTModel)


Data2 <- read.csv("Fuel.csv", header=TRUE, sep=";")
Data2
attach(Data2)
str(Data2)
Country <- as.factor(Country)
Year <- as.factor(Year)
RTModel2 <- rpart(mpg ~., data=Data2, method="anova", 
                 control=rpart.control(minsplit=6, minbucket=5, maxdepth=3))
Fig2 <- plot(as.party(RTModel2)) 
print(RTModel2)
summary(RTModel2)
rsq.rpart(RTModel2)

