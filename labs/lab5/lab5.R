rm(list=ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab5")

# Data imputation using mean and median

Data <- read.csv("DI.csv", header=TRUE, sep= ";")

mean(Data$Post_BP)
median(Data$Post_BP)

Data$Post_BP

Data$Post_BP[is.na(Data$Post_BP)]

mean(Data$Post_BP[!is.na(Data$Post_BP)])
median(Data$Post_BP[!is.na(Data$Post_BP)])

Data1 <- Data
Data1$Post_BP[is.na(Data1$Post_BP)] <- mean(Data1$Post_BP[!is.na(Data1$Post_BP)])

Data1$Post_BP

Data2 <- Data

Data2$Post_BP[is.na(Data2$Post_BP)] <- median(Data2$Post_BP[!is.na(Data2$Post_BP)])

Data2$Post_BP

# Step 2: data imputation using Regression

Data3 <- Data[,-1]

cor(Data3)
cor(Data3, use = "complete.obs")
symnum(cor(Data, use = "complete.obs"))

Ind_Function <- function(u)
{
  x <- dim(length(u))
  x[which(is.na(u))] <- 0
  x[which(!is.na(u))] <- 1
  return(x)
}

Data3$I <- Ind_Function(Data3$Post_BP)
Data

model<- lm(Data3$Post_BP ~ Data3$Pre_BP)
summary(model)

for(i in 1:nrow(Data3))
{
  if (Data3$I[i] == 0)
  { 
    Data3$Post_BP[i] = 78.26482 + 0.46276 * Data3$Pre_BP[i]
  }
}

Data3$Post_BP


