# Assignmen 3: Data imputation

## Setup

rm(list = ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/assignments/assign3")

library(readxl)
library(mice)
library(VIM)

## functions

## main

data <- read_excel("Project Data.xlsx")

miceData <- mice(data, m=5)

miceData <- complete(miceData)

summary(miceData)
