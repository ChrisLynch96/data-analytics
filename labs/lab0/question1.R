library(numbers)
library(ggplot2)

count = 0
dataset = sample(1:1000000000, 1000000, replace = T)
i <- 0

while(i < length(dataset)) {
  x1 = sample(dataset, 1);
  x2 = sample(dataset, 1);
  if (coprime(x1, x2)) {
    count = count + 1;
  }
  i = i + 1
}

result = count/length(dataset)
result
