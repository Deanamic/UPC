options(digits=17)
X <- c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29)
f <- c(20, 29, 61, 67, 91, 67, 72, 67, 72, 75, 47, 50, 34, 20, 21, 28, 21, 12, 14, 7, 7, 7, 8, 6, 2, 6, 1, 0, 1, 2)
sum(X*X*f)

Mean <- sum(X*f)/sum(f)
Mean
Mean2 <- sum(X*X*f)/sum(f)
Mean2
pmm <- ((Mean2 - Mean*Mean)/Mean)^-1
pmm
rmm <- (Mean*pmm)/(1-pmm)
rmm
Mean
var <- Mean2 - Mean*Mean
var

cumf <- cumsum(f)/sum(f)
cumf
realf <- pnbinom(0:29, rmm, pmm, lower.tail = T, log.p = F)
realf
max(abs(cumf-realf))

foo <- function(x){
  val = -prod(f*(lgamma(x[1]+f) + x[1]*log(x[2]) + f*log(1-x[2]) - lfactorial(f) - lgamma(x[1])))
}

ans <- nlm(f = foo, c(rmm, pmm))$estimate
ans
