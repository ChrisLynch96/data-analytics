# Lab8: sampling methods to generate random samples from different distributions.

# setup

rm(list = ls())

# functions

gen_samples <- function(lambda = 1, num_samples, sample_size) {
  samples <- list()
  
  for(i in 1:num_samples) {
    samples[[i]] <- gen_exponential_sample_via_cdf_inverse(lambda, sample_size)
  }
  
  return(samples)
}

gen_exponential_sample_via_cdf_inverse <- function(lambda = 1, sample_size) {
  exponential_distribution <- rep(NA, sample_size)
  uniform_distribution <- runif(sample_size, 0, 1)
  
  for(i in 1:sample_size) {
    exponential_distribution[i] <- cdf_inverse(lambda, uniform_distribution[i])
  }
  return(exponential_distribution)
}

cdf_inverse <- function(lambda, x) {
  inverse <- (-(1/lambda))*(log(1-x))
  return(inverse)
}

generate_pdfs <- function(samples, lambda) {
  pdfs <- list()
  for(i in 1:length(samples)) {
    pdfs[[i]] <- dexp(samples[[i]], rate = lambda)
  }
  
  return(pdfs)
}

ks_testing <- function(samples) {
  results <- rep(NA, length(samples))
  
  for(i in 1:length(samples)) {
    ks_result <- ks.test(samples[[i]], "pexp")
    results[i] <- ks_result$p.value
  }
  
  return(results)
}

# main

set.seed(124)
lambda <- 1
num_samples <- 2000
sample_size <- 2000

samples <- gen_samples(lambda, num_samples, sample_size)

# checking that the generated samples follow a exponential distribution
hist(samples[[1]])

sample_pdfs <- generate_pdfs(samples, lambda)

# Testing the pdf of the exponetial distribution sample is correct
plot(x = samples[[1]], y = sample_pdfs[[1]], xlab = "x", ylab = "Probability density", type = "p")

# kolmogorov smirnov test
results <- ks_testing(samples)

sprintf("Mean p value from ks test over %d samples: %f", num_samples, mean(results))
sprintf("Variance of p value from ks test over %d samples: %f", num_samples, var(results))
sprintf("Max p value from ks test over %d samples: %f", num_samples, max(results))
sprintf("Min p value from ks test over %d samples: %f", num_samples, min(results))

