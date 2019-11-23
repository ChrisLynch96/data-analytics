# Lab 7: Two stage modelling for variable imputation that can be 0 or 1

## Setup

rm(list=ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab7")

## functions

## main

SIS <- 

glm.sign <- glm (I(earnings>0) ~ male + over65 + white + immig + educ_r + any.ssi + any.welfare + any.charity, data=SIS, family=binomial(link=logit))