# Performing rejection sampling on a gamma distribution where alpha is non-Integer

rm(list = ls())

# functions
f <- function(x) {
  return(dgamma(x, 5.5, 3))
}

g <- function(x) {
  return(dgamma(x, 5, 2))
}

M <- function(x_star) {
  return(f(x_star)/g(x_star))
}

h <- function(M, gx) {
  return(M * gx)  
}

# main
sample <- rep(NA, 2000)

x_star <- (5.5-5)/(3-2)
m <- M(x_star)
count <- 1

while(count <= 2000) {
  x <- runif(1, 0, 10)
  xi <- g(x)
  ui <- runif(1, 0, h(m, x))
  
  if(ui <= f(x)) {
    sample[count] <- x
    count <- count + 1
  }
}

sample

hist(sample)

plot(x = sample, y = f(sample), xlab = "x", ylab = "Probability density", type = "p")

ks.test(sample, "pgamma", 5.5, 3)

