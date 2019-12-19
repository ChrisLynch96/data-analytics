# Assignmen 3: Data imputation

## Setup

rm(list = ls())
setwd("~/workspace/github.com/ChrisLynch96/data-analytics/assignments/assign3")

library(readxl)
library(mice)
library(rpart)
library(partykit)

data <- read_excel("Project Data.xlsx")

## Imputing

### imputing only the Xs

x.only <- data[,c(2,3,4,5,6,7,8,9,10)]

fx.only <- x.only[,-2]
fx.imp <- mice(fx.only,m=5,maxit=50,meth='pmm',seed=500)
fx.complete <- complete(fx.imp, 1)

g0x.only <- subset(x.only, Group==0)
g0x.only <- g0x.only[,-2]
g0x.imp <- mice(g0x.only,m=5,maxit=50,meth='pmm',seed=500)
g0x.complete <- complete(g0x.imp, 1)

g1x.only <- subset(x.only, Group==1)
g1x.imp <- mice(g1x.only,m=5,maxit=50,meth='pmm',seed=500)
g1x.complete <- complete(g1x.imp, 1)

### imputing only the Ys

y.only <- data[,c(2,3,11,12,13,14,15,16,17)]

fy.only <- y.only[,-2]
fy.imp <- mice(fy.only,m=5,maxit=50,seed = 500)
fy.complete <- complete(fy.imp, 1)

g0y.only <- subset(y.only, Group==0)
g0y.only <- g0y.only[,-2]
g0y.imp <- mice(g0y.only,m=5,maxit=50,seed=500)
g0y.complete <- complete(g0y.imp, 1)

g1y.only <- subset(y.only, Group==1)
g1y.imp <- mice(g1y.only,m=5,maxit=50,seed=500)
g1y.complete <- complete(g1y.imp, 1)

### Combining X and Y variables

f.complete <- cbind(fx.complete, fy.complete[,-1])
g0.complete <- cbind(g0x.complete, g0y.complete[,-1])
g1.complete <- cbind(g1x.complete, g1y.complete[,-1])

sub_sets <- list (
  f.complete,
  g0.complete,
  g1.complete
)

formulas <- list(
  Response~X1 + X2 + X3 + X4 + X5 + X6 + X7,
  Response~Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7,
  Response~X1 + X2 + X3 + X4 + X5 + X6 + X7 + Y1 + Y2 + Y3 + Y4 + Y5 + Y6 + Y7
)

## Model creation

models <- list()
xerrors <- list()
cps <- list()

count = 1
pdf("plots1.pdf", width = 600, height = 600)
for(i in seq(length(sub_sets))) {
  for(j in seq(length(formulas))) {
    model <- rpart(formula = formulas[[j]], data = sub_sets[[i]], parms=list(split="information"), method = "class")
    opt <- which.min(model$cptable[,"xerror"])
    pruned_model <- prune(model, cp = model$cptable[opt, "CP"])
    plot(as.party(pruned_model))
    xerrors[count] <- model$cptable[opt, "xerror"]
    cps[count] <- model$cptable[opt, "CP"]
    count = count + 1
  }
}
dev.off()

## Dustbin

#
#fx.noimp <- rpart(formula = formulas[[1]], data = data, parms=list(split="information"), method = "class")
#fy.noimp <- rpart(formula = formulas[[2]], data = data, parms=list(split="information"), method = "class")
#fxy.noimp <- rpart(formula = formulas[[3]], data = data, parms=list(split="information"), method = "class")

## Model creation with imputation

#fx.withimp <- rpart(formula = formulas[[1]], data = x.complete, parms=list(split="information"), method = "class")
#fy.withimp <- rpart(formula = formulas[[2]], data = y.complete, parms=list(split="information"), method = "class")
#fxy.withimp <- rpart(formula = formulas[[3]], data = full.complete, parms=list(split="information"), method = "class")



