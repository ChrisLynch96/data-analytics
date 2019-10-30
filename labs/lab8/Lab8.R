# Lab8: sampling methods to generate random samples from different distributions.

# setup

rm(list = ls())

# functions

gen_exponential_dist <- function(num_samples, lambda) {
  exponential_distribution <- rep(NA, num_samples)
  
  for(i in 1:num_samples) {
    exponential_distribution[i] <- exponential_sample(lambda)
    print(exponential_distribution[i])
  }
  
  return(exponential_distribution)
}

exponential_sample <- function(lambda) {
  sample <- (-(1/lambda))*(log(1-runif(1, 0, 1))) # stick in a random value between 0 and 1
  return(sample)
}

sample <- gen_exponential_dist(2000, 1)