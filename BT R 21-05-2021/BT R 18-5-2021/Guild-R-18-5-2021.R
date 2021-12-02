

setwd("C:/Users/ASUS/Desktop/R/BT R 18-5-2021")

# Chapter 5 => Plot => Bieu do dang x, y 
# Them mot so tool cho ve bieu do 
# Phan tich du lieu 


# 7.1. Pie chart
# H5N1 Avian Infuenza A => WHO World Health Organization
BFCases <- read.table(file = "BirdFluCases.txt", sep="\t", header = TRUE)
# Phan cach giua cac cot du lieu chung ta la tab tham so: sep = "\t" 


names(BFCases)
str(BFCases)


# Thao tac thong ke so case theo nam 
Cases <- rowSums(BFCases[,2:16])
names(Cases)<-BFCases[,1]
Cases


# Ve bieu do pie chart 
# Bieu do chuan - standard pie chart
# Ham chia man hinh 
par(mfrow= c(2,2), mar= c(3,3,2,1))
# mfrow = c(2,2)=> Chia màn h??nh ra làm 4 góc
# c=(1,4); c=(4,1)
# par(mfrow= c(1,4), mar= c(3,3,2,1))
# par(mfrow= c(4,1), mar= c(3,3,2,1))
# mar=c(3,3,2,1): Khoang trang giua cac bieu do 
# margin: bottom, left, top, right


pie(Cases, main = "Standard pie chart")
pie(Cases, main = "Grey color",
    col = gray(seq(0.4, 1.0, length=6)),
    clockwise = TRUE
)
pie(Cases, main = "Rainbow color",
    col = rainbow(6),
    clockwise = TRUE
)

# Install Package libary plotrix
# install.packages("plotrix")
# Goi thu vien plotrix
library(plotrix)


pie3D(Cases, main = "3D Pie Chart",
      explode=0.1,
      labels = names(Cases),
      labelcex=0.6,
)

op <- par(mfrow= c(2,2), mar= c(3,3,2,1))
pie(Cases, main = "Standard pie chart")
pie(Cases, main = "Grey color",
    col = gray(seq(0.4, 1.0, length=6)),
    clockwise = TRUE
)
pie(Cases, main = "Rainbow color",
    col = rainbow(6),
    clockwise = TRUE
)
pie3D(Cases, main = "3D Pie Chart",
      explode=0.1,
      labels = names(Cases),
      labelcex=0.6,
)
par(op)




# 7.2 Bar Chart and Strip Chart
BFDeaths <- read.table(file="BirdFluDeaths.txt",
                       sep="\t",
                       header = TRUE,
)
names(BFDeaths)
str(BFDeaths)
Deaths <-rowSums(BFDeaths[,2:16])
names(Deaths)<-BFDeaths[,1]
Deaths


# Chia man hinh thanh 4 phan 2*2
par(mfrow=c(2,2), mar= c(3,3,2,1))


barplot(Cases, main="Bird Flu Cases")
Counts<-cbind(Cases, Deaths)
barplot(Counts)
barplot(t(Counts), col=gray(c(0.5,1)))
barplot(t(Counts), beside=TRUE)


Counts
t(Counts)


# Su dung ham merge de noi 2 dataframe lai voi nhau 
# Su dung ham write.table(dataframe, file = "new_name.txt",...)
# Su dung 2 ham tren ungs dung cho dataset RIKZ.txt 
# Bien thanh mot dataset RIKZ_A.txt co chua cac cot Sample, Richness, Shannon 

Benthic <-read.table(file="RIKZ2.txt", header=TRUE)

Bent.M <-tapply(Benthic$Richness, 
                INDEX=Benthic$Beach, 
                FUN=mean)
Bent.M

Bent.sd <-tapply(Benthic$Richness, 
                 INDEX=Benthic$Beach, 
                 FUN=sd)
Bent.sd

MSD <- cbind(Bent.M, Bent.sd)
MSD
barplot(Bent.M)


bp <- barplot(Bent.M, xlab="Beach",
              ylim = c(0,20),
              ylab="Richness",
              col=rainbow(9)
)
arrows(bp, Bent.M, 
       bp, Bent.M+Bent.sd,
       lwd=1.5,
       angle=90,
       length=0.1
)
box()


Benth.le <- tapply(Benthic$Richness,
                   INDEX=Benthic$Beach,
                   FUN=length)
# se= standard error= 
# standard deviation/square root of the sample size
#
Bent.se <- Bent.sd/sqrt(Benth.le)
Bent.se
# STRIP CHART


stripchart(Benthic$Richness~Benthic$Beach,
           vert=TRUE,
           pch=1,
           method="jitter",
           jit=0.05,
           xlab="Beach",
           ylab="Richness")
points(1:9, Bent.M, pch=16,
       cex=1.5)
arrows(1:9, Bent.M,
       1:9, Bent.M+Bent.se,
       lwd=1.5,
       angle=90,
       length = 0.1)
arrows(1:9, Bent.M,
       1:9, Bent.M-Bent.se,
       lwd=1.5,
       angle=90,
       length = 0.1)

