

setwd("C:\\Users\\PC\\Desktop\\R\\BT R 18-5-2021")

# EX1: Su dung Pie Chart de ve du lieu BirdFlu
#...Ve 1 bieu do hien thi so nguoi chet moi nam 
#...Ve 1 bieu do hien thi so nguoi chet cho moi quoc gia 

BFDeaths <- read.table("BirdFluDeaths.txt", sep = "\t", header = TRUE)
names(BFDeaths)
str(BFDeaths)


# Tinh tong so nguoi chet moi nam 
Deaths <- rowSums(BFDeaths[,2:16])
names(Deaths) <- BFDeaths[,1]
Deaths


# Tinh tong so nguoi chet cua moi quoc gia tu 2003-2008
Deaths_col <- colSums((BFDeaths[,2:16]))
names(Deaths_col) <- names(BFDeaths[,2:16])
Deaths_col


# Ve bieu do 
# Bieu do pie chart
library(plotrix)
par(mfrow=c(2,2), mar= c(3,3,2,1))
pie(Deaths, main = "Total deaths per years")
pie3D(Deaths, main = "3D Pie Chart",
      explode=0.1,
      labels = names(Deaths),
      labelcex=0.6,)


barplot(Deaths_col,
        main="Total death per country",
        xlim = c(0, 20),
        ylim = c(0, 120),
        col = "blue")
box()


# EX2: Ve bieu do strip chart cho dataset Vegetation.txt 
# (su dung 2 bien R - Richness va bien Transect tuong tu bien Beach trong csdl RIKZ.txt) 
# Tao 1 bieu do trong do gia tri trung binh duoc ve thanh cac diem den. 
# Standard error duoi dang cac duong xung quanh gia tri trung binh va du lieu quan sat duoi dang cac vong tron mo. 
# (nhý phan STRIP CHART)


# Input Data
Vegetation <- read.table("Vegetation2.txt", sep = "\t", header = TRUE)
names(Vegetation)
str(Vegetation)


Richness <- rowSums(Vegetation[5])
names(Richness) <- Vegetation[,1]
Richness

Vegetation_new <- data.frame(Richness, Vegetation$Transect)
colnames(Vegetation_new)[2] <- "Transect"
Vegetation_new



Veg.M <-tapply(Vegetation_new$Richness, 
                INDEX=Vegetation_new$Transect, 
                FUN=mean)
Veg.M


Veg.sd <-tapply(Vegetation_new$Richness, 
                 INDEX=Vegetation_new$Transect, 
                 FUN=sd)
Veg.sd

MSD <- cbind(Veg.M, Veg.sd)
MSD
barplot(Veg.M)


bp <- barplot(Veg.M, xlab="Transect",
              ylim = c(0,20),
              ylab="Richness",
              col=rainbow(8)
)
box()


Veg.le <- tapply(Vegetation_new$Richness,
                   INDEX=Vegetation_new$Transect,
                   FUN=length)
Veg.le

# se= standard error= 
# standard deviation/square root of the sample size

Veg.se <- Veg.sd/sqrt(Veg.le)
Veg.se
# STRIP CHART


stripchart(Vegetation_new$Richness~Vegetation_new$Transect,
           vert=TRUE,
           pch=1,
           method="jitter",
           jit=0.05,
           xlab="Transect",
           ylab="Richness")

points(1:8, Veg.M, pch=16,
       cex=1.5)
arrows(1:8, Veg.M,
       1:8, Veg.M+Veg.se,
       lwd=1.5,
       angle=90,
       length = 0.1)
arrows(1:8, Veg.M,
       1:8, Veg.M-Veg.se,
       lwd=1.5,
       angle=90,
       length = 0.1)

