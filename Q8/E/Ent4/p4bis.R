options(digits = 12)
dd <- read.csv2("ENT4.csv")
ddGC = dd[1:35, ]
ddGE = dd[36:70, ]

###1 y 2 (dan lo mismo las dos formas) 

var.test(dd$AnEvol~factor(dd$Grupo))
t.test(dd$AnEvol~factor(dd$Grupo), var_equal = FALSE)


###3 y 4  

chisq.test(dd$EstCiv, dd$Grupo, correct = FALSE, p = rep(1/length(x), length(x)), rescale.p = FALSE) 


###5 y 6 


var.test(dd$MemorTrab_B~factor(dd$Grupo))
t.test(dd$MemorTrab_B~factor(dd$Grupo), var_equal = TRUE) 

###7 Y 8 

var.test(dd$MemorTrab_P~factor(dd$Grupo))
t.test(dd$MemorTrab_P~factor(dd$Grupo), var_equal = FALSE) 
 
### 9 Y 10

t.test(ddGC$MemorTrab_P - ddGC$MemorTrab_B)

### 11 y 12

t.test(ddGE$MemorTrab_P - ddGE$MemorTrab_B)

### 13 y 14

var.test(ddGC$MemorTrab_B, ddGC$MemorTrab_P)
t.test(ddGC$MemorTrab_B, ddGC$MemorTrab_P, var_equal = TRUE)


### 15 y 16 

var.test(ddGE$MemorTrab_B, ddGE$MemorTrab_P)
t.test(ddGE$MemorTrab_B, ddGE$MemorTrab_P, var_equal = FALSE)



## 17 y 18 

t.test(MemorTrab_P-MemorTrab_B~Grupo, dd)





