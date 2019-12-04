library(rpart)
library(partykit)
library(randomForest)

rm(list = ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab3")

Data <- read.csv("DT-Credit.csv", header=TRUE, sep= ";")

str(Data)

# Some data cleaning. changing some variables to factors and removing columns
cols <- c(1:2, 4:10, 12:22, 24:32)
Data[cols] <- lapply(Data[cols], factor)

# Removing the observations column
Data <- Data[-1]

names(Data)
str(Data)

# Training model
model <-rpart(RESPONSE~., data=Data, control=rpart.control(minsplit=60, minbucket=30, maxdepth=4))

plot(as.party(model))

# Creating second model now purely pruning example
model2 <- rpart(RESPONSE~., data=Data)
plot(as.party(model2))

# Getting the complexity parameter vaue which minimizes the error
opt <- which.min(model2$cptable [,"xerror"])
cp <- model2$cptable[opt,"CP"]

# pruning the model
model_pruned <- prune.rpart(model2, cp)
plot(as.party(model_pruned))

# Building a decision tree via the random forest method
RF <- randomForest(RESPONSE~.,data=Data)
print(RF)

importance(RF)

varImpPlot(RF)

plot(RF)
