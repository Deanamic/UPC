
count <- function(X, label, val) {
  return (sum(X[label] == val))
}

SexT <- table(Data$Grupo, Data$Sexo)
SexAns <- chisq.test(SexT, correct = F)
SexAns$statistic
SexAns$p.value

NivT <- table(Data$Grupo, Data$NivEstud)
StuAns <- chisq.test(NivT, correct = F)
StuAns$statistic
StuAns$p.value


DiagT <- table(Data$Grupo, Data$Diag)
DiagAns <- chisq.test(DiagT, correct = F)
DiagAns$statistic
DiagAns$p.value

EdadAov <- aov(Edad ~ Grupo, data = Data)
summary(EdadAov)[[1]]$F[1]
summary(EdadAov)[[1]]$`Pr(>F)`[1]

AnysAov <- aov(AnEvol ~ Grupo, data = Data)
summary(AnysAov)[[1]]$F[1]
summary(AnysAov)[[1]]$`Pr(>F)`[1]


var.test(Data.GC$AnEvol, Data.GE$AnEvol, alternative = "two.side", conf.level = 1 - alpha, ratio = 1)
AnysAns <- t.test(Data.GC$AnEvol, Data.GE$AnEvol, var.equal = T, alternative = "two.side", correct = F)
AnysAns$p.value

var.test(Data.GC$VelocProc_B, Data.GE$VelocProc_B, alternative = "two.side", conf.level = 1 - alpha, ratio = 1)
VelocBAov <- aov(VelocProc_B ~ Grupo, data = Data)
summary(VelocBAov)[[1]]$F[1]
summary(VelocBAov)[[1]]$`Pr(>F)`[1]

AtenBAov <- aov(AtenVig_B ~ Grupo, data = Data)
summary(AtenBAov)[[1]]$F[1]
summary(AtenBAov)[[1]]$`Pr(>F)`[1]

MemorBAov <- aov(MemorTrab_B ~ Grupo, data = Data)
summary(MemorBAov)[[1]]$F[1]
summary(MemorBAov)[[1]]$`Pr(>F)`[1]

VisBAov <- aov(AprenVis_B ~ Grupo, data = Data)
summary(VisBAov)[[1]]$F[1]
summary(VisBAov)[[1]]$`Pr(>F)`[1]

RazonBAov <- aov(RazonRes_B ~ Grupo, data = Data)
summary(RazonBAov)[[1]]$F[1]
summary(RazonBAov)[[1]]$`Pr(>F)`[1]

VelocPAov <- aov(VelocProc_P ~ Grupo, data = Data)
summary(VelocPAov)[[1]]$F[1]
summary(VelocPAov)[[1]]$`Pr(>F)`[1]

AtenPAov <- aov(AtenVig_P ~ Grupo, data = Data)
summary(AtenPAov)[[1]]$F[1]
summary(AtenPAov)[[1]]$`Pr(>F)`[1]

MemorPAov <- aov(MemorTrab_P ~ Grupo, data = Data)
summary(MemorPAov)[[1]]$F[1]
summary(MemorPAov)[[1]]$`Pr(>F)`[1]


VisPAov <- aov(AprenVis_P ~ Grupo, data = Data)
summary(VisPAov)[[1]]$F[1]
summary(VisPAov)[[1]]$`Pr(>F)`[1]

RazonPAov <- aov(RazonRes_P ~ Grupo, data = Data)
summary(RazonPAov)[[1]]$F[1]
summary(RazonPAov)[[1]]$`Pr(>F)`[1]

?aov
