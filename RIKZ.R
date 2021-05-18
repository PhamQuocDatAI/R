#Download file RIKZ.txt tren Google ClassRoom ve
#Sample C1 P1 P2 P3 P4 P5 P6 P7 P8 P9 P10
#P11 P12 P13 P14 P15 P16 P17 P18 P19 P20 P21 P22 P24
#P25 N1 CR1 CR2 CR3 CR4 CR5 CR6 CR7 CR8 CR9 CR10
#CR11 CR12 CR13 CR14 CR15 CR16 CR17 CR18 CR19
#CR20 CR21 CR22 CR23 CR24 CR25 CR26 CR27 CR28
#M1 M2 M3 M4 M5 M6 M7 M8 M9 M10 M11 M12 M14 M15 M16
#M17 I1 I2 I3 I4 I5
#week angle1 angle2 exposure salinity
#temperature NAP penetrability grainsize


# Thiet lap thu muc hien hanh
setwd("C:\\Users\\PC\\Desktop\\R")


#RIKZ.txt
Benthic <- read.table("RIKZ.txt", header = TRUE)
names(Benthic)
str(Benthic)


# Bien Species (loai) tu cot thu 2 den 76 trong bien Benthic 
Species <- Benthic[,2:76]
names(Species)
str(Species)


# Kiem tra dimensions - chieu cua bien Species 
n <- dim(Species)
n


# 45 dong - tuong ung voi 45 sites - vi tri thu thap mau vat 
# Tuong ung voi moi vi tri se ghi nhan duoc nhung loai 
# sinh vat bien nao
# Co bao nhieu sinh vat bien o vi tri so 1 
sum(Species[1,], na.rm = TRUE)


# Ket qua 143 loai sinh vat bien xuat hien o site 1 
sum(Species[2,], na.rm = TRUE)


#... Lam 45 lan de kiem tra so luong sinh vat bien xuat hien tai cac site
TA <- vector(length = n[1])
for (i in 1:n[1]) {
  TA[i] <- sum(Species[i,], na.rm = TRUE)
}
TA


# Ham rowsums: tinh toan tong cua cac cot trong hang 
# tham so na.rm = TRUE => Loai bo cac gia tri NA 
TA02 <- rowSums(Species, na.rm = TRUE)
TA02


# Di vao chi tiet tai tung vi tri quan sat 
sum(Species[1,]>0, na.rm = TRUE)


# Ket qua chung ta co 11 loai khac nhau xuat hien tai vi tri 1 
Richness <- vector(length=n[1])
for (i in 1:n[1]) {
  Richness[i] <- sum(Species[i,]>0, na.rm=TRUE)
}
Richness


Richness02 <- rowSums(Species>0, na.rm = TRUE)
Richness02


# Chi so da dang loai
#https://en.wikipedia.org/wiki/Diversity_index
# Tim hieu cach tinh chi so da dang loai 
# 10h40.
# H - sum bien chay tu i -> m cua bien p: xac xuat * log10 p
RS <- rowSums(Species, na.rm=TRUE)
prop <- Species / RS
H <- -rowSums(prop * log10(prop), na.rm= TRUE)
H


# Ket hop lai het nhung gi da lam vao 1 ham cua rieng minh 
# sau nay su dung de phan tich nhung du lieu tuong tu 
Index.function <-function(Spec, Choice){
  if (Choice=="Richness") {
    Index <- rowSums(Species>0, na.rm = TRUE)
  }
  if (Choice=="Total Abundance") {
    Index <- rowSums(Species, na.rm = TRUE)
  }
  if (Choice=="Shannon") {
    RS <- rowSums(Species, na.rm=TRUE)
    prop <- Species / RS
    Index <- -rowSums(prop * log10(prop), na.rm= TRUE)
  }
  list(Index=Index, MyChoice= Choice)
}


Shannon <- Index.function(Species,"Shannon")

Richness
Shannon

new <- cbind(Richness, Shannon[["Index"]])
colnames(new)[2] <- "Shannon"
test <- merge(new, Benthic)
write.table(test, file = "RIKZ_A.txt")
