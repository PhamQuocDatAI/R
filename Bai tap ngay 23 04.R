#1000 datasets, mỗi dataset cần làm 1 biểu đồ, và lưu nó dưới
#dạng file jpeg
# For i is from 1 to 1000:
  # Extract dataset i
  # Choose lable, color,... for dataset i
  # Tạo graph cho dataset i
  # Save the graph for dataset i
# End of loop

setwd("C:/Users/DELL/Desktop/R")
Owls<-read.table(file = "Owls.txt", header = TRUE)
names(Owls)
str(Owls)
unique(Owls$Nest)         #Có 27 loại Nest

#Vẽ biểu đồ cho từng loại Nest
Owls.ATV <- Owls[Owls$Nest=="AutavauxTV",]
plot(x=Owls.ATV$ArrivalTime,
     y=Owls.ATV$NegPerChick,
     xlab="Arrival Time",
     main="AutavauxTV",
     ylab = "Negotiation behaviour")
Owls.Bot <- Owls[Owls$Nest=="Bochet",]
plot(x=Owls.ATV$ArrivalTime,
     y=Owls.ATV$NegPerChick,
     xlab="Arrival Time",
     main="Bochet",
     ylab = "Negotiation behaviour")


AllNests<-unique(Owls$Nest)
for (i in 1:27) {
  Nest.i <- AllNests[i]
  Owls.i <- Owls[Owls$Nest==Nest.i,]
  YourFileName <- paste(Nest.i, ".jpg", sep = "")
  jpeg(file=YourFileName)
  plot(x=Owls.i$ArrivalTime, 
       y= Owls.i$NegPerChick,
       xlab="Arrival Time",
       main=Nest.i,
       ylab = "Negotiation behaviour"  
       )
  dev.off()
}
# Bài tập
#Sử dụng file dữ liệu temperature.xls; có chứa thông tin dữ liệu ở 31 trạm thời tiết (temperature observations)
#Sử dụng dữ liệu nhiệt độ (temperature) và thời gian (time) để vẽ biểu đồ plot của 31 trạm này
#Lưu dưới dạng jpeg




