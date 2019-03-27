options(digits = 10)

require(readr)


#### Dean
param1 <- -2.8 #a
param2 <- -1.8 #b
param3 <- c(1.04, 1.16) #E[ti]

####

#### JON
param1 <- 0.3 #a
param2 <- 1.3 #b
param3 <- c(5.17, 0.28) #E[ti]
####

#### CLARA
param1 <- -1.3 #a
param2 <- -0.3 #b
param3 <- c(2.42, 0.52) #E[ti]
####


#### Mariona
param1 <- -3.8 #a
param2 <- -2.8 #b
param3 <- c(0.76, 1.6) #E[ti]
####

dades <- read.csv2("Zhu , Dean-ent3.csv")$x
dades <- read.csv2("Tapia Perez, Clara-ent3.csv")$x
dades <- read.csv2("González Esteve, Mariona-ent3.csv")$x
mostres <- length(dades)
mitjana <- sum(dades)/mostres
invmitjana <- sum(1/dades)/mostres

if(!require(rootSolve)) install.packages('rootSolve')

f <- function(lambda) {
  E2 <- param3[2]
  E1 <- param3[1]
  b <- param2
  ff <- besselK(lambda, b + 1)/besselK(lambda, b) 
  return (E2*E1 + (2*b*ff)/(lambda) - ff*ff)
}

lambda <- uniroot(f, lower = 1e-9, upper = 700, tol = 1e-9)$root
nu <- param3[1]/(besselK(lambda, param2 + 1)/besselK(lambda, param2))
lambda
nu

f11 <- function(lambda, nu) {
  flb <- besselK(lambda, param2)
  flb1 <- besselK(lambda, param2+1)
  flb2 <- besselK(lambda, param2+2)
  return ((nu*nu/flb) * (flb2 - (flb1*flb1/flb)))
}
f11(lambda, nu)

f22 <- function(lambda, nu) {
  flb <- besselK(lambda, param2)
  flb1 <- besselK(lambda, param2+1)
  flb2 <- besselK(lambda, param2+2)
  b <- param2
  return (-4*b/(nu*nu*lambda*lambda) + flb2/(nu*nu*flb) - (flb1/(nu*flb))^2)
}
f22(lambda, nu)

f12 <- function(lambda, nu) {
  flb <- besselK(lambda, param2)
  flb1 <- besselK(lambda, param2+1)
  flb2 <- besselK(lambda, param2+2)
  return (-2/lambda * (flb1/flb) + flb2/flb - (flb1/flb)^2)
}
f12(lambda, nu)

fmv <- function(vec) {
  lambda <- vec[1]
  nu <- vec[2]
  fv1 <- -sum(dades/(2*nu)) - sum(nu/(2*dades)) + mostres*(besselK(lambda, param2 + 1)/besselK(lambda, param2)) - mostres*param2/lambda
  fv2 <- -mostres*param2/nu + sum(lambda/(2*nu*nu) * dades) - sum(lambda/(2*dades))
  return (c(fv1, fv2))
}
?multiroot

ans <- multiroot(fmv, start = c(lambda, nu), positive = T)
lambdamv <- ans$root[1]
numv <- ans$root[2]

lambdamv
numv

fish11 <- function(vec) {
  lambda <- vec[1]
  nu <- vec[2]
  b <- param2
  flb <- besselK(lambda, param2)
  flb1 <- besselK(lambda, param2+1)
  flb2 <- besselK(lambda, param2+2)
  return (mostres*((flb1/(lambda*flb)) - flb2/flb + (flb1/flb)^2 + b/(lambda*lambda)))
}

fish12 <- function(vec) {
  lambda <- vec[1]
  nu <- vec[2]
  b <- param2
  return (mostres*(mitjana/(2*nu*nu) - 1/(2*invmitjana)))
}

fish22 <- function(vec) {
  lambda <- vec[1]
  nu <- vec[2]
  b <- param2
  return (-mostres*(b/(nu*nu)) - (lambda*mitjana/(nu^3)))
}

fish11(c(lambdamv,numv))
fish12(c(lambdamv,numv))
fish22(c(lambdamv,numv))

