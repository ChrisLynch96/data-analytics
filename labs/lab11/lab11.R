# setup

rm(list <- ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab11")

# functions


# main

## initial tao is inverse of average and variance
x <- c(12.8,10.5,13.2,13.0,7.0,11.0,13.4,13.2,9.5,11.0,10.9,4.6,5.8,3.2,9.8,0.2,11.2, 7.2, 14.7, 5.9, 9.7, 17.6, 8.5, 6.8, 7.2, 12.2, 16.7, 10.4, 14.2, 5.7)
mu <- 8
variance <- 4
alpha <- 5
beta <- 1
tao <- 1/variance

# doing to g stuff

initialTao <- var(x)
tempMu <- ((1000*mean(x)*initialTao) + ((1000*tao)) + initialTao)