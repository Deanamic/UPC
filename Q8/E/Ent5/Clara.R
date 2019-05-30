
#QÜESTIONARI 5 ESTADÍSTICA  
options(digits = 9)
library(car)
#Fixem el directori en el que treballarem, particularment on tenim guardat el fitxer amb les dades.

setwd("~/Github/UPC/Q8/E/Ent5")

#Llegim les dades i tot seguit les visualitzem 
dades = read.csv2("Dades1.csv")
View(dades)
#summary(dades)


#=================== PRIMERA PART ============================================================#
#Fem el model 1:
model1 <- lm(bodyfat~Age+Height+Hip+Knee+Forearm, dades)
summary(model1)

anova(model1)

vif(model1)


#Fem el model 2:
model2 <- lm(bodyfat~Age+Height+Hip, dades)
summary(model2)


v <- abs(rstudent(model2))
n = length(v)
total = 0
for (i in 1:n){
  if(v[i] > 2) total = total + 1
}
total = (total/n)*100

#studres 4.5

max(abs(dffits(model2)))

(predict(model2, data.frame(Age=45.5 , Height=69.9, Hip=100.8), interval="prediction", level=.95))
(predict(model2, data.frame(Age=45.5 , Height=69.9, Hip=100.8), interval="confidence", level=.95))
#=================== PRIMERA PART ============================================================#




library(car)
library(emmeans)

#=================== SEGONA PART ============================================================#
model3<-lm(bodyfat~Diet,dades,contrasts=list(Diet="contr.treatment"))
summary(model3)
model4<-lm(bodyfat~Diet,x=T,dades,contrasts=list(Diet="contr.sum"))
summary(model4)

Anova(model3)
Anova(model4)

(emm<-emmeans(model4,~Diet))

cld(emm,level=0.95,adjust="tukey")
#=================== SEGONA PART ============================================================#