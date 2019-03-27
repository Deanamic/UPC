multiplicacions<- c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29)
dades <- c(20, 29, 61, 67, 91, 67, 72, 67, 72, 75, 47, 50, 34, 20, 21, 28, 21, 12, 14, 7, 7, 7, 8, 6, 2, 6, 1, 0, 1, 2)
multi <- sum(dades*multiplicacions*multiplicacions)
multi
hola <- dades*multi
sum(hola)
#suma ben calculada

X <- rep(multiplicacions, dades) #tenim el vector de mostres

#suma del primer mom = mean = r(1-p) / p
#Apartat 1
(nombre_obs <- sum(dades))
sum(X)
suma_xi_n <- sum(X)/nombre_obs
suma_xi_n
#variança = r(1-p)/p^2
suma_quadrats_xi_n <- sum(X*X)/nombre_obs
suma_quadrats_xi_n 
p_aprox <- suma_xi_n/(suma_quadrats_xi_n-(suma_xi_n)^2)
p_aprox
#Apartat 2
r_aprox <- (suma_xi_n * p_aprox)/(1- p_aprox)
r_aprox
#Apartat 3
esperança <- (r_aprox * (1 - p_aprox))/(p_aprox)
esperança
#Apartat 4
variança <- (r_aprox * (1-p_aprox)) / (p_aprox^2)
variança
#Apartat 5
pnbinom(3, r_aprox, p_aprox, lower.tail = T, log.p = F)

iter = 1
vector_distribucio<-c()
sum(dades[1:iter])
for (i in dades){
  vector_distribucio <- c(vector_distribucio, sum(dades[1:iter]) / nombre_obs)
  iter = iter + 1
}
vector_distribucio
maxim = -1
iter = 0
for (i in vector_distribucio){
  if(abs(pnbinom(iter, r_aprox, p_aprox, lower.tail = T, log.p = F) - vector_distribucio[iter+1])>maxim){
    maxim = abs(pnbinom(iter, r_aprox, p_aprox, lower.tail = T, log.p = F) - vector_distribucio[iter + 1])
    print(maxim)
    print("hola")
    print(iter)
  }
  iter = iter + 1
}
sprintf("El maxim es %s",maxim)

#Apartat B
#install.packages("combinat")
#require(combinat)
#-N*x[1]*log(x[2]) - log(1-x[2])*nombre_obs - sum(lgamma(x[1]) + Xrep) - lgamma(Xrep + 1) - lgamma(x[1])
#7) i 8)
X
fu <- function(x){
  res <- 0
  for (i in X){
    res = res + lgamma(x[1] + i) + x[1]*log(x[2]) + i*log( (1-x[2])) - lfactorial(i) - lgamma(x[1])
  }
  return (-res)
}
options(digits=17)
?nlm
hola <- nlm(f = fu, c(5.7,0.3), steptol = 1e-10)
hola
r_B <- hola$estimate[1]
p_b <- hola$estimate[2]
p_b
r_B
fu(c(r_B,p_b))
#9)
esperanca_b <- (r_B*(1-p_b)) / (p_b)
esperanca_b 
prova <- sum(X) / nombre_obs
#surten els dos valors iguals

#10)
varianca_b <- (r_B*(1-p_b)) / (p_b)^2
varianca_b
#11)

iter = 1
vector_distribucio_b<-c()
for (i in dades){
  vector_distribucio_b <- c(vector_distribucio_b, sum(dades[1:iter]) / nombre_obs)
  iter = iter + 1
}
vector_distribucio_b
maxim_b = -1
iter = 0
for (i in vector_distribucio_b){
  if(abs(pnbinom(iter, r_B, p_b, lower.tail = T, log.p = F) - vector_distribucio_b[iter+1])>maxim_b){
    maxim_b = abs(pnbinom(iter, r_B, p_b, lower.tail = T, log.p = F) - vector_distribucio_b[iter + 1])
    print(maxim)
    print("hola")
    print(iter)
  }
  iter = iter + 1
}
sprintf("El maxim es %s",maxim_b)

#13)esperanca
alpha <- 4.5*nombre_obs +2
beta <- sum(X) + 1.5
esperanca_c <- alpha / (alpha + beta) #Aixo es el valor esperat de p
#14)variança
varianca_c <- (alpha * beta)/((alpha + beta)^2 * (alpha + beta + 1))
#Amb lo de dalt estic calculant algo aixi com la variancia de l'estimador(?)
#15)r = 4.5 i p = esperanca
esperanca_x <- (4.5*(1-esperanca_c)) / (esperanca_c)
#16)
varianca_x <- (4.5*(1-esperanca_c)) / (esperanca_c^2)
esperanca_c
varianca_c
esperanca_x
varianca_x

