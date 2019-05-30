alpha <- 0.05
options(digit = 20)

#############################################################
# Ejecutar con Ctrl+Shift+S                                 #
# Reemplazar:                                               #
# - Edad por la variable numerica del apartado 1,2          #
# - EstCiv por la variable categorica del apartado 3,4      #
# - MemorTrab por la variable de los apartados 5-18         #
# - El nombre del fichero                                   #
# !Imprime los Estadisticos del T-student en valor absoluto #
#############################################################
Data <- read_csv2("/home/dean/Github/UPC/Q8/E/Ent4/Martos Berruezo, Alejandro.csv")

Data.GC <- Data[which(Data$Grupo == 'GC'),]
Data.GE <- Data[which(Data$Grupo == 'GE'),]

VarT.Test <- function(X, label1, label2, alpha = 0.05) {
  X$label1 <- X[[label1]]
  X$label2 <- X[[label2]]
  p.val = var.test(label1 ~ label2, data = X, alternative = "two.side")$p.value
  if(p.val >= alpha) {
    b = T
  } else {
    b = F
  }
  return (t.test(label1 ~ label2, data = X, var.equal = b, alternative = "two.side", correct = F))
}

#1,2
EdadAns <- VarT.Test(Data, "AnEvol", "Grupo")
print(abs(as.vector(EdadAns$statistic))) #en valor absolut els estadistics???
print(EdadAns$p.value)

#3,4
CivT <- table(Data$Grupo, Data$EstCiv)
CivAns <- chisq.test(CivT, correct = F)
print(as.vector(CivAns$statistic))
print(CivAns$p.value)

#5,6
VerbBAov <- VarT.Test(Data, "MemorTrab_B", "Grupo")
print(abs(as.vector(VerbBAov$statistic)))
print(as.vector(VerbBAov$p.value))
#7,8
VerbPAov <- VarT.Test(Data, "MemorTrab_P", "Grupo")
print(abs(as.vector(VerbPAov$statistic)))
print(as.vector(VerbPAov$p.value))

#9,10,11,12
##Potser cal girar l'ordre dels primers dos parametres (aixo fa P - B)
cmpC <- t.test(Data.GC$MemorTrab_P, Data.GC$MemorTrab_B, paired=TRUE)
cmpE <- t.test(Data.GE$MemorTrab_P, Data.GE$MemorTrab_B, paired=TRUE)
print(cmpC$conf.int[c(1,2)])
print(cmpE$conf.int[c(1,2)])
print(abs(as.vector(cmpC$statistic)))
print(cmpC$p.value)
print(abs(as.vector(cmpE$statistic)))
print(cmpE$p.value)

#17,18
Data$Dif <- Data$MemorTrab_P - Data$MemorTrab_B
p.val <- var.test(Dif ~ Grupo, data = Data)$p.value #same var
if(p.val >= alpha) {
  b = T
} else {
  b = F
}
Ans <- t.test(Dif ~ Grupo,data = Data, var.equal = b)
print(abs(as.vector(Ans$statistic)))
print(Ans$p.value)
