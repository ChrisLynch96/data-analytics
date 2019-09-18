library(rpart)
library(partykit)

data = read.csv("DT-Credit.csv", header=TRUE, sep=";")
str(data)
attach(data)

DT_Model <- rpart(RESPONSE~., data=data, control=rpart.control(minsplit=60, minbucket=30, maxdepth=4 )) 

plot(as.party(DT_Model))
print(DT_Model)

Target=ifelse(RESPONSE==1, "Y", "N")

data <- data.frame(data, Target)

str(data)

data1 <- data[,-32]

DT_Model1 <- rpart(Target~., data=data1, control=rpart.control(minsplit=60, minbucket=30, maxdepth=8 ))

plot(as.party(DT_Model1))
print(DT_Model1)