library(readxl)
library(rpart)
library(partykit)

rm(list = ls())

# functions

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

get_average <- function(num_runs, formula, data) {
  xerrors = rep(NA, num_runs)
  cps = rep(NA, num_runs)
  
  for(i in 1:num_runs) {
    model <- rpart(formula = formula, data = data, parms=list(split="information"), method = "class")
    opt <- which.min(model$cptable[,"xerror"])
    xerrors[i] <- model$cptable[opt, "xerror"]
    cps[i] <- model$cptable[opt, "CP"]
  }
  result <- list(
    mean(xerrors),
    getmode(cps)
  )
  
  return(result)
}

# main

data <- read_excel("Project Data.xlsx")

formulas <- list(
  Response~X1 + X2 + X3 + X4 + X5 + X6 + X7,
  Response~Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7,
  Response~X1 + X2 + X3 + X4 + X5 + X6 + X7 + Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7
)

sub_sets <- list(
  data,
  group1 <- subset(data, group = 0),
  group2 <- subset(data, group = 1)
)

xerrors <- list()
cps <- list()

count = 1
for(i in seq(length(sub_sets))) {
  for(j in seq(length(formulas))) {
    result <- get_average(200, formulas[[j]], sub_sets[[i]])
    xerrors[count] <- result[[1]]
    cps[count] <- result[[2]] 
    count = count + 1
  }
}

print(xerrors)
print(cps)

# Prune and print decision trees

pruned_models <- list()
count <- 1

pdf("models.pdf", onefile = TRUE)
for(i in seq(length(sub_sets))) {
  for(j in seq(length(formulas))) {
    model <- rpart(formula = formulas[[j]], data = sub_sets[[i]], method = "class")
    pruned_models[count] <- prune(model, cp = cps[[count]])
    plot(as.party(pruned_models[[count]]))
    count <- count + 1
  }
}
dev.off()

# The difficult way

png("modeldata_X.png", width = 500, height = 500)
model <- rpart(formula = formulas[[1]], data = sub_sets[[1]], method = "class")
pruned_model <- prune(model, cp = cps[[1]])
plot(as.party(pruned_model))
dev.off()

png("modeldata_Y.png", width = 500, height = 500)
model <- rpart(formula = formulas[[2]], data = sub_sets[[1]], method = "class")
pruned_model <- prune(model, cp = cps[[2]])
plot(as.party(pruned_model))
dev.off()

png("modeldata_XY.png", width = 500, height = 500)
model <- rpart(formula = formulas[[3]], data = sub_sets[[1]], method = "class")
pruned_model <- prune(model, cp = cps[[3]])
plot(as.party(pruned_model))
dev.off()

png("modelG0_X.png", width = 500, height = 500)
model <- rpart(formula = formulas[[1]], data = sub_sets[[2]], method = "class")
pruned_model <- prune(model, cp = cps[[4]])
plot(as.party(pruned_model))
dev.off()

png("modelG0_Y.png", width = 500, height = 500)
model <- rpart(formula = formulas[[2]], data = sub_sets[[2]], method = "class")
pruned_model <- prune(model, cp = cps[[5]])
plot(as.party(pruned_model))
dev.off()

png("modelG0_XY.png", width = 500, height = 500)
model <- rpart(formula = formulas[[3]], data = sub_sets[[2]], method = "class")
pruned_model <- prune(model, cp = cps[[6]])
plot(as.party(pruned_model))
dev.off()

png("modelG1_X.png", width = 500, height = 500)
model <- rpart(formula = formulas[[1]], data = sub_sets[[3]], method = "class")
pruned_model <- prune(model, cp = cps[[7]])
plot(as.party(pruned_model))
dev.off()

png("modelG1_Y.png", width = 500, height = 500)
model <- rpart(formula = formulas[[2]], data = sub_sets[[3]], method = "class")
pruned_model <- prune(model, cp = cps[[8]])
plot(as.party(pruned_model))
dev.off()

png("modelG1_XY.png", width = 500, height = 500)
model <- rpart(formula = formulas[[3]], data = sub_sets[[3]], method = "class")
pruned_model <- prune(model, cp = cps[[9]])
plot(as.party(pruned_model))
dev.off()

