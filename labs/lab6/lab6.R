library(VIM)

setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab6")
rm(list = ls())
Data <- read.csv("HS.csv", header=TRUE, sep= ",")

head(Data)
summary(Data)

Impute1 <- kNN(Data, variable= "Genre", k=5)
summary(Impute1)

Impute2 <- kNN(Data, variable= c("Audience..score..", "Profitability"), k=6)
summary(Impute2)

Impute3 <- kNN(Data, variable= "Rotten.Tomatoes..", k=6)
summary(Impute3)