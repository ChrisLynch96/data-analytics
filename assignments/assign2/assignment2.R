library(readxl)
library(rpart)
library(partykit)

rm(list = ls())

data <- read_excel("Project Data.xlsx")

str(data)
counter = 1
models <- list()

model1 <- rpart(Response~X1 + X2 + X3 + X4 + X5 + X6 + X7, data, method = "class", parms = list(split = "information"))
models[[counter]] = model1
counter = counter + 1

model2 <- rpart(Response~Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7, data, method = "class", parms = list(split = "information"))
models[[counter]] = model2
counter = counter + 1

model3 <- rpart(Response~X1 + X2 + X3 + X4 + X5 + X6 + X7 + Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7, data, method = "class", parms = list(split = "information"))
models[[counter]] = model3
counter = counter + 1

# Group = 0
group0 <- subset(data, group = 0)
model4 <- rpart(Response~X1 + X2 + X3 + X4 + X5 + X6 + X7, group0, method = "class", parms = list(split = "information"))
models[[counter]] = model4
counter = counter + 1

model5 <- rpart(Response~Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7, group0, method = "class", parms = list(split = "information"))
models[[counter]] = model5
counter = counter + 1

model6 <- rpart(Response~X1 + X2 + X3 + X4 + X5 + X6 + X7 + Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7,group0, method = "class", parms = list(split = "information"))
models[[counter]] = model6
counter = counter + 1

# Group = 1
group1 <- subset(data, group = 1)
model7 <- rpart(Response~X1 + X2 + X3 + X4 + X5 + X6 + X7, group1, method = "class", parms = list(split = "information"))
models[[counter]] = model7
counter = counter + 1

model8 <- rpart(Response~Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7, group1, method = "class", parms = list(split = "information"))
models[[counter]] = model8
counter = counter + 1

model9 <- rpart(Response~X1 + X2 + X3 + X4 + X5 + X6 + X7 + Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7,group0, method = "class", parms = list(split = "information"))
models[[counter]] = model9

# Writing to pdf
# Ending for loop to write the list of models to a pdf file
pdf("models.pdf", onefile = TRUE)
for (i in seq(length(models))) {
  printcp(models[[i]])
  plot(as.party(models[[i]]))
}
dev.off()