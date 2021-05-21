# Chuong 7 tiep theo


# 7.3 Boxplot 

# Su dung Boxplots de hien thi du lieu Owl Data

setwd("C:\\Users\\PC\\Desktop\\R\\BT R 21-05-2021")


# Xem xet hanh vi cua cu con xem no co phan ung nhu the nao
# khi ma co su hien dien cua cu cha va cu me?
# 21:30 -> 5:30 qua 2 dem

Owls <- read.table(file = "Owls.txt", sep="\t", header= TRUE)
names(Owls)
str(Owls)

# Ve bieu do Boxplot
boxplot(Owls$NegPerChick)
par(mfrow= c(2,2), mar= c(3,3,2,1))
boxplot(NegPerChick ~ SexParent, data = Owls)
boxplot(NegPerChick ~ FoodTreatment, data = Owls)
boxplot(NegPerChick ~ SexParent*FoodTreatment, data = Owls)
boxplot(NegPerChick ~ SexParent*FoodTreatment,
        names= c("F/Dep","M/Dep","F/Sat","M/Sat"), 
        data = Owls)
boxplot(NegPerChick ~ Nest, data = Owls)


par(mar=c(2,2,3,3))
boxplot(NegPerChick ~ Nest, 
        data = Owls,
        axes=FALSE, 
        ylim=c(-3,8.5))
axis(2, at=c(0,2,4,6,8))
text(x=1:27, y=-2, 
     labels= levels(Owls$Nest),
     cex=0.75, srt=65)

