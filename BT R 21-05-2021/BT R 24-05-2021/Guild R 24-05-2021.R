

setwd("C:/Users/ASUS/Desktop/R/BT R 24-05-2021")

#7.5 Xem lai ham plot 

methods(plot)
help(plot)

# Tham so - Y nghia 
# main - them tieu de cho graph
# xlab, ylab - nhan cot cho x, y
# log: log="x", log="y", log="xy"=> creates logaricthmic axes
# type="p"; "l", "b", "o", "h","s", "n"


# Cau 1: Tim hieu cac loai plot thong qua tham so type 


Benthic <-read.table(file="RIKZ2.txt", header=TRUE)
Benthic$fBeach <- factor(Benthic$Beach)
plot(Benthic$Richness ~ Benthic$fBeach)


# Cau 2: Tim hieu mot so ham hay dung voi plot 
# Tim hieu y nghia cua cac ham duoi 
# Van dung ket hop voi ham plot de ve do thi 
# plot.new
# win.graph
# windows
# savePlot
# locator
# range
# matplot
# persp
# cut
# split
