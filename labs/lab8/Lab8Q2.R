# setup

rm(list = ls())

# functions

gen_gamma_samples_from_exp_variables <- function(k = 5, lambda = 3, num_samples, sample_size) {
  gamma_samples <- list()
  
  # first generate exponential samples
  exp_samples = gen_exp_samples(lambda, num_samples, sample_size)
  
  # randomely choose samples to sum
  for(j in 1:num_samples) {
    sum <- rep(0, sample_size)
    indexes <- sample(1:num_samples, k)
    for(i in 1:k) {
      sum <- sum + exp_samples[[indexes[i]]]
    }
    gamma_samples[[j]] <- sum 
  }
  
  return(gamma_samples)
}

gen_exp_samples <- function(lambda = 1, num_samples, sample_size) {
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

generate_pdfs <- function(samples, shape, lambda) {
  pdfs <- list()
  for(i in 1:length(samples)) {
    pdfs[[i]] <- dgamma(samples[[i]],shape = shape, rate = lambda)
  }
  
  return(pdfs)
}

ks_testing <- function(samples, shape, rate) {
  results <- rep(NA, length(samples))
  
  for(i in 1:length(samples)) {
    ks_result <- ks.test(samples[[i]], "pgamma", shape, rate)
    results[i] <- ks_result$p.value
  }
  
  return(results)
}

# main
k <- 5
lambda <- 3
num_samples <- 2000
sample_size <- 1000

gamma_samples <- gen_gamma_samples_from_exp_variables(k, lambda, num_samples, sample_size)

# Checking the summation of exponential samples gives a correct gamma distribution
hist(gamma_samples[[1]])

sample_pdfs <- generate_pdfs(gamma_samples, k, lambda)

plot(x = gamma_samples[[1]], y = sample_pdfs[[1]], xlab = "x", ylab = "Probability density", type = "p")

# kolmogorov smirnov test
results <- ks_testing(gamma_samples, k, lambda)

sprintf("Mean p value from ks test over %d samples: %f", num_samples, mean(results))
sprintf("Variance of p value from ks test over %d samples: %f", num_samples, var(results))
sprintf("Max p value from ks test over %d samples: %f", num_samples, max(results))
sprintf("Min p value from ks test over %d samples: %f", num_samples, min(results))

