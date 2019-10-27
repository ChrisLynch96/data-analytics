library(readxl)
library(rpart)
library(partykit)

rm(list = ls())

# functions

get_average_min_xerror <- function(num_runs, formula, data) {
  xerrors = rep(NA, num_runs)
  
  for(i in 1:num_runs) {
    model <- rpart(formula = formula, data, method = "class", control = rpart.control())
    opt <- which.min(model$cptable[,"xerror"])
    xerrors[i] <- model$cptable[opt, "xerror"]
  }
  
  return(mean(xerrors))
}

# main

data <- read_excel("Project Data.xlsx")

xerrors <- list()

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

count = 1
for(i in seq(length(sub_sets))) {
  for(j in seq(length(formulas))) {
    xerrors[count] <- get_average_min_xerror(100, formulas[[j]], sub_sets[[i]])
    print("subset:")
    print(str(sub_sets[[i]]))
    print("formula:")
    print(formulas[[j]])
    print("xerror")
    print(xerrors[count])
    count = count + 1
  }
}

print(xerrors)

# garbage

multiple_runs <- function(num_runs) {
  cps <- list()
  for(i in 1:num_runs) {
    counter = 1
    models <- list()
    model1 <- rpart(Response~X1 + X2 + X3 + X4 + X5 + X6 + X7, data, method = "class", parms = list(split = "information"))
    models[[counter]] = model1
    cp <- get_optimal_cp(model1)
    cps[[counter]] = cps[[counter]] + cp
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
  } 
}

#function to do multiple runs
multiple_runs <- function(model,num_runs,dataset,prune_tree=FALSE){
  for (i in 1:n){
      opt <- which.min(rpart_model$cptable[,"xerror"])
      cp <- rpart_model$cptable[opt, "CP"]
  }
  return(fraction_correct)
}
# Writing to pdf
# Ending for loop to write the list of models to a pdf file
pdf("models.pdf", onefile = TRUE)
for (i in seq(length(models))) {
  printcp(models[[i]])
  plot(as.party(models[[i]]))
}
dev.off()