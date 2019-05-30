alpha <- 0.05
options(digit = 20)

###########################################################
# Reemplazar:                                             #
# - Edad por la variable numerica del apartado 1,2        #
# - EstCiv por la variable categorica del apartado 3,4    #
# - AprenVis por la variable de los apartados 5-18       #
# - El nombre del fichero                                 #
###########################################################

Data <- read_csv2("/home/dean/Github/UPC/Q8/E/Ent4/Tapia Perez, Clara.csv")

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
EdadAns <- VarT.Test(Data, "Edad", "Grupo")
print(as.vector(EdadAns$statistic)) #en valor absolut els estadistics???
print(EdadAns$p.value)

#3,4
CivT <- table(Data$Grupo, Data$NivEstud)
CivAns <- chisq.test(CivT, correct = F)
print(as.vector(CivAns$statistic))
print(CivAns$p.value)

#5,6
VerbBAov <- VarT.Test(Data, "AprenVis_B", "Grupo")
print(as.vector(VerbBAov$statistic))
print(as.vector(VerbBAov$p.value))
#7,8
VerbPAov <- VarT.Test(Data, "AprenVis_P", "Grupo")
print(as.vector(VerbPAov$statistic))
print(as.vector(VerbPAov$p.value))

#9,10,11,12
difC <- Data.GC$AprenVis_P - Data.GC$AprenVis_B
difE <- Data.GE$AprenVis_P - Data.GE$AprenVis_B

##Potser cal girar l'ordre dels primers dos parametres
cmpC <- t.test(Data.GC$AprenVis_P, Data.GC$AprenVis_B, paired=TRUE)
cmpE <- t.test(Data.GE$AprenVis_P, Data.GE$AprenVis_B, paired=TRUE)
print(cmpC$conf.int[c(1,2)])
print(cmpE$conf.int[c(1,2)])
print(as.vector(cmpC$statistic))
print(cmpC$p.value)
print(as.vector(cmpE$statistic))
print(cmpE$p.value)

#17,18
cmpT <- Data$AprenVis_P - Data$AprenVis_B
p.val <- var.test(cmpT ~ Grupo, data = Data)$p.value #same var
if(p.val >= alpha) {
  b = T
} else {
  b = F
}
Ans <- t.test(cmpT ~ Grupo,data = Data, var.equal = b)
print(as.vector(Ans$statistic))
print(Ans$p.value)

