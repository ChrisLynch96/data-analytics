rm(list = ls())

Data <- read.csv("DT-Credit.csv", header=TRUE, sep= ";")

str(Data)

# Some data cleaning. changing some variables to factors and removing columns
cols <- c(1:2, 4:10, 12:22, 24:32)
Data[cols] <- lapply(Data[cols], factor)
str(Data)
Data <- Data[-1]