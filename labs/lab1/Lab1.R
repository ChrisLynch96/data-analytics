library(rpart)
library(partykit)

rm(list = ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab1")

data = read.csv("DT-Credit.csv", header=TRUE, sep=";")
str(data)
attach(data)

DT_Model <- rpart(RESPONSE~., data=data, control=rpart.control(minsplit=60, minbucket=30, maxdepth=4)) 

plot(as.party(DT_Model))
print(DT_Model)

Target=ifelse(RESPONSE==1, "Y", "N")

data <- data.frame(data, Target)

data = data[,-1]
str(data)

data1 <- data[,-31]

str(data1)

DT_Model1 <- rpart(Target~., data=data1, control=rpart.control(minsplit=60, minbucket=30, maxdepth=4))

plot(as.party(DT_Model1))
print(DT_Model1)
