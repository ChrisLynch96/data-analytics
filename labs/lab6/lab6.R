library(VIM)

rm(list = ls())
Data <- read.csv("HS.csv", header=TRUE, sep= ",")
Data
str(Data)
attach(Data)
head(Data)
summary(Data)
