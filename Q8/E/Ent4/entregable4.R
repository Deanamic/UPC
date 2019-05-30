dades = read_csv2("/home/dean/Github/UPC/Q8/E/Ent4/Zhu , Dean.csv")
edat = dades$Edad
grup = dades$Grupo
diagnostic = dades$Diag
apB = dades$AprenVis_B
apP = dades$AprenVis_P

#A
var.test(edat~grup) #gives same variance
tedat = t.test(edat~grup, var.equal = TRUE)
#1
tedat$statistic
#2
tedat$p.value #pvalue > 0.05, this means H0
#3
tdiag = prop.test(table(diagnostic, grup), correct = F)
tdiag$statistic
#4
tdiag$p.value
#B
var.test(apB~grup) #gives same variance
tapB = t.test(apB~grup, var.equal = TRUE)
#5
tapB$statistic
#6
tapB$p.value
#7
var.test(apP~grup) #gives same variance
tapP = t.test(apP~grup, var.equal = TRUE)
tapP$statistic
#8
tapP$p.value

#C
apPC = dades$AprenVis_P[dades$Grupo == 'GC']
apBC = dades$AprenVis_B[dades$Grupo == 'GC']
apPE = dades$AprenVis_P[dades$Grupo != 'GC']
apBE = dades$AprenVis_B[dades$Grupo != 'GC']
difapC = apPC - apBC
difapE = apPE - apBE
#9, 10
t.test(difapC)$conf.int
#11, 12
t.test(difapE)$conf.int
#13
dadesC = dades[dades$Grupo == 'GC',]
dadesE = dades[dades$Grupo != 'GC',]
tpC = t.test(dadesC$AprenVis_B, dadesC$AprenVis_P, paired = TRUE)
tpC$statistic
#14
tpC$p.value
#15
tpE = t.test(dadesE$AprenVis_B, dadesE$AprenVis_P, paired = TRUE)
tpE$statistic
#16
tpE$p.value
#17
difapT = dades$AprenVis_P - dades$AprenVis_B
var.test(difapT~grup) #same var
res = t.test(difapT~grup, var.equal = TRUE) #da que no (makes sense)
res$statistic
#18
res$p.value

