# Performing rejection sampling on a gamma distribution where alpha is non-Integer

rm(list = ls())

# functions
f <- function(x) {
  return(dgamma(x, 5.5, 3))
}

g <- function(x) {
  return(dgamma(x, 5, 2))
}

M <- function() {
  f_obvs <- rgamma(5000, 5.5, 3)
  f_dist <- dgamma(f_obvs, 5.5, 3)
  
  g_obvs <- rgamma(5000, 5, 2)
  g_dist <- dgamma(g_obvs, 5, 2)
  return(max(f_dist/g_dist))
}

h <- function(M, g_pdf) {
  return(M * g_pdf)  
}

# main
sample <- rep(NA, 2000)

### Need to generate M such that the max(f(x)/g(x)) doesn't return a massive number
m <- M()
count <- 1
i <- 1

while(count <= 2000) {
  xi <- g(i)
  ui <- runif(1, 0, h(m, i))
  
  if(ui <= f(i)) {
    sample[count] <- xi
    count <- count + 1
  }
  i <- i + 1
}

sample
