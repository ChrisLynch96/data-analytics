dataset = sample(1:60, 100000, replace = T)
i = 0
count = 0

while(i < length(dataset)) {
  pair = sample(dataset, 2)
  if(diff(pair) <= 20) {
    count = count + 1
  }
  i = i + 1
}

result = count/length(dataset)
result