# Set working direction (folder)
setwd("C:/Users/ASUS/Desktop/R/BT R 11-5-2021")


#Convert temperature.xls => temperature.txt
#Declare a frame variable to store temperature.txt data. In my case, the separate between two columns is “.” signal



TP <- read.table("Temperature.txt", header = TRUE)
#You should check all variables (column), it should available for analysing…
names(TP)
str(TP)



#Our function:
#Check how many station (tram khi tuong) in our dataset
AllStations <- unique(TP$Station)
N <- length(AllStations)

for (i in 1:N) {
  Station.i <- as.character(AllStations[i])
  print(Station.i)
  TPi <- TP[TP$Station == Station.i ,]
  YourFileName <- paste(Station.i, ".jpg", sep = "") 
  jpeg(file = YourFileName)
  plot(x = TPi$dDay2 , y = TPi$Temperature, 
       xlab = "Days since 1 January 1990",
       ylab = "Temperature",
       main = Station.i)
  dev.off()
}




# Exercise 2
Owls <- read.table(file = "Owls.txt", header = TRUE, dec = ".")
names(Owls)
str(Owls)

ifelse(Owls$FoodTreatment == "Satiated", Owls$NestNight <- paste(Owls$Nest, "1",sep = "_"),
       Owls$NestNight <- paste(Owls$Nest, "2", sep = "_"))
       
Owls[1:50,]                           
#You can also do this with: Owls$NestNight <- paste(Owls$Nest, Owls$FoodTreatment,sep = "_") 

AllNestsNights <- unique(Owls$NestNight)
N <- length(AllNestsNights)
for (i in 1:N) {
  NestNight.i <- as.character(AllNestsNights[i])
  print(NestNight.i)
  Owlsi <- Owls[Owls$NestNight == NestNight.i ,]
  YourFileName <- paste(NestNight.i, ".jpg", sep = "") 
  #jpeg(file = YourFileName)
  plot(x = Owlsi$ArrivalTime , y = Owlsi$NegPerChick, 
       xlab = "Arrival Time",
       ylab = "Sibling negotiation",
       main = NestNight.i)
  #dev.off()
}

