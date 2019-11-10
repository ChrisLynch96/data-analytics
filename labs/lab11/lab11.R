# setup

rm(list = ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/labs/lab11")

# functions

get_new_mu <- function(n, x_bar, tao, new_mu, new_tao) {
  dist_mu <- ((n*x_bar*tao) + (new_mu*new_tao))/((n*tao) + new_tao)
  dist_var <- ((n*tao) + new_tao)^-1
  mus <- rnorm(1000, dist_mu, dist_var)
  return(mean(mus))
}

get_new_tao <- function(alpha, n, beta, x, new_mu) {
  s <- S(x, new_mu)
  taos <- rgamma(1000, alpha + (n/2), beta + (s/2))
  return(mean(taos))
}

S <- function(x, mu) {
  results <- rep(NA, length(x))
  
  for(i in 1:length(x)) {
    results[i] <- (x[i]-mu)^2
  }
  return(sum(results))
}

# main
  
# starting values
init_mu <- 8
init_variance <- 4
init_alpha <- 5
init_beta <- 1
init_tao <- 1/init_variance

# Values given from data (assumed not to change)
x <- c(12.8,10.5,13.2,13.0,7.0,11.0,13.4,13.2,9.5,11.0,10.9,4.6,5.8,3.2,9.8,0.2,11.2, 7.2, 14.7, 5.9, 9.7, 17.6, 8.5, 6.8, 7.2, 12.2, 16.7, 10.4, 14.2, 5.7)
tao <- 1/(var(x))
mu <- mean(x)
n <- length(x)

num_iterations <- 500
new_mu <- init_mu
new_tao <- init_tao
mus <- rep(NA, num_iterations)
taos <- rep(NA, num_iterations)
for(i in 1:num_iterations) {
  new_mu <- get_new_mu(n, mu, tao, new_mu, new_tao)
  mus[i] <- new_mu
  new_tao <- get_new_tao(init_alpha, n, init_beta, x, new_mu)
  taos[i] <- new_tao
}

sprintf("final mu value: %s", new_mu)
sprintf("final tao value: %s", new_tao)

plot(seq.int(1, 500), mus)
plot(seq.int(1, 500), taos)

# Need to plot the final value of mu and variance