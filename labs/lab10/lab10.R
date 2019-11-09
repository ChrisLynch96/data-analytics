# setup

rm(list = ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab10")

# functions

get_theta <- function(num_samples) {
  
  values <- rep(NA, num_samples)
  for (i in 1:num_samples) {
    x <- gen_x()
    values[i] <- (x^2)/(5*pi*(1+(x^2)))
  }
  return(sum(values)/num_samples)
}

gen_x <- function() {
  return (5/(1-runif(1, 0, 1)))
}

# main

## Want to estimate P(X > 5) There's some funky values going on but lets just say that
num_samples <- 1000

## Appaently 6% of cauchy values are over 5 sooooo theta will probably come close to 6% i.e E[P(X > 5)] is close to 6%
theta <- get_theta(num_samples)
