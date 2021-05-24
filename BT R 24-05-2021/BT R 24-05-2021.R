

setwd("C://Users//PC//Desktop//R//BT R 24-05-2021")

# Cau 1: Tim hieu cac loai plot thong qua tham so type 
Benthic <- read.csv("RIKZ2.txt", sep = "\t", header = TRUE)

par(mfrow= c(3,3), mar= c(3,3,2,1))

# Type of plot
# 1 Bieu do diem
plot(Benthic$Richness ~ Benthic$Beach,
     type = 'p',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')

# 2 Bieu do duong 
plot(Benthic$Richness ~ Benthic$Beach,
     type = 'l',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')

# 3 Ket hop bieu do diem va duong
plot(Benthic$Richness ~ Benthic$Beach,
     type = 'b',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')

# 4 Cac diem trong ket noi voi cac duong
plot(Benthic$Richness ~ Benthic$Beach,
     type = 'c',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')

# 5 Cac diem va duong duoc to dam 
plot(Benthic$Richness ~ Benthic$Beach,
     type = 'o',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')

# 6 Bieu do bac thang
plot(Benthic$Richness ~ Benthic$Beach,
     type = 's',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')

# 7 Bieu do bac thang 
plot(Benthic$Richness ~ Benthic$Beach,
     type = 'S',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')

# 8 Bieu do duong thang dung
plot(Benthic$Richness ~ Benthic$Beach,
     type = 'h',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')

# 9 Bieu do trong 
plot(Benthic$Richness ~ Benthic$Beach,
     type = 'n',
     xlab = 'Richness',
     xlim = c(0, 10),
     ylab = 'Beach',
     ylim = c(0,25),
     main = 'Richness ~ Beach', 
     col = 'blue')



# Cau 2: Tim hieu mot so ham hay dung voi plot 
# Tim hieu y nghia cua cac ham duoi 
# Van dung ket hop voi ham plot de ve do thi

?plot.new
plot.new()
# => Tao 1 trang ve do thi moi

?win.graph

?windows

?savePlot

# => Dung de luu nhung bieu do duoc ve
# savePlot(filename = "Rplot",
#          type = c("wmf", "emf", "png", "jpg", "jpeg", "bmp",
#                   "tif", "tiff", "ps", "eps", "pdf"),
#          device = dev.cur(),
#          restoreConsole = TRUE)
# filename => Dat ten cho hinh anh 
# type => dinh dang anh ban muon luu do thi la PNG hay JPEG, BMP, ...


?locator

# => Doc vi tri cua con tro do hoa khi nhan chuot 
# locator(n = 512, type = "n", ...)
# n : so diem toi da de xac dinh vi tri
# type : ki hieu ten cua cac loai bieu do "n", "p", "l", ....

?range

# Tra ve 1 vector chua gia tri nho nhat va gia tri nho nhat cua cac doi so dua vao

?matplot

?split

?cut
