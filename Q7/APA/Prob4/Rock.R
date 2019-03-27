library(datasets)
library(nnet)
library(lattice)
library(ggplot2)
library(caret)
require(doMC)

registerDoMC(cores = 4)
set.seed(12321)
data(rock)
rock.x <- data.frame(area = scale(rock$area), perim = scale(rock$peri), shape = scale(rock$shape))
rock.y <- log(rock$perm)

nsize <- seq(1, 40, by = 1)
decays <- 10^seq(-3, 0, by = 0.1)
trc <- trainControl (method="LOOCV")
model.LOOCV <- train (y = rock.y, x = rock.x, method='nnet', maxit = 1000, trace = FALSE, linout = TRUE,
                      tuneGrid = expand.grid(.size=nsize,.decay=decays), trControl=trc)
save(model.LOOCV, file = "~/Github/UPC/Q7/APA/Prob4/LOOCV.method_a.mod")
load ("./LOOCV.method_a.mod")

model.LOOCV$results
model.LOOCV$bestTune

SaveSize = model.LOOCV$bestTune$size
Savedecay = model.LOOCV$bestTune$decay
loSavetrc <- trainControl (method="LOOCV", savePredictions = TRUE)
set.seed(13123)
Savemodel.LOOCV <- train (y = rock.y, x = rock.x, method='nnet', maxit = 1000, trace = FALSE, linout = TRUE,
                      tuneGrid = expand.grid(.size=SaveSize,.decay=Savedecay), trControl=Savetrc)
RMSE(Savemodel.LOOCV$pred$pred, Savemodel.LOOCV$pred$obs)
rock.pred = Savemodel.LOOCV$pred$pred
plot(rock.y, rock.pred, xlab="Observada", ylab="Predita", type="p", xlim = c(0,8), ylim = c(0,8), xaxs = "i", yaxs = "i")
lines(c(0,8.5), c(0,8.5), col="blue")
