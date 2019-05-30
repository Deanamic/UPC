library(car)
library(emmeans)
dd <- read.csv2("Dades2.csv")
options(digits=9)

#resposta i variables lm
resp = dd$Density
v1 = dd$Weight
v2 = dd$Height
v3 = dd$Chest
v4 = dd$Abdomen
v5 = dd$Wrist

#A predir
p1 = 175.7
p2 = 70.1
p3 = 99.4
p4 = 91.7
p5 = 18.2

#factor tractament
ft = dd$Diet

#1
M1 = lm(resp~v1+v2+v3+v4+v5)
summary(M1) #a
anova(M1) #b
max(vif(M1)) #c
M2 = lm(resp~v1+v4+v5) #d
summary(M2) #d
plot(rstudent(M2),col="red",pch="+",main="Residuals studentitzats") #e
abline(h=c(-2,0,2),lty=2)
rextranys = rstudent(M2)[rstudent(M2)<(-2) | rstudent(M2)>2]
rtot = length(rextranys)/length(rstudent(M2))
rtot*100
plot(dffits(M2))
max(abs(dffits(M2))) #10
apredir = data.frame(v1 = p1,v4 = p4, v5 = p5)
predict(M2, apredir, interval = "prediction", level=.95) #f
predict(M2, apredir, interval = "confidence", level=.95) #f
#2
M3 = lm(resp~ft, contrasts = list(ft = "contr.Treatment"))
summary(M3)
M4 = lm(resp~ft, contrasts = list(ft = "contr.sum"))
summary(M4)
cld(emmeans(M4, ~ft))

##  Respostes Tom?s Ortega
#1  0.726545
#2  0.0102399
#3  1.14828
#4  103.088
#5  2.22e-16
#6  0.020342140
#7  10.4489914
#8  3
#9  4
#10 0.399483741
#11 1.03685938
#12 1.07717826
#13 1.05558949
#14 1.05844815
#15 1.07050200
#16 1.05592650
#17 0.413174
#18 46.00002
#19 0.0149239
#20 1.06633969
#21 1.07466431
#24 3

