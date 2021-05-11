setwd("c:/Users/PC/Desktop/R")

# Nhập data
data = read.table("Owls.txt", header = TRUE)


# Câu 1:
# Sử dụng library(dplyr) để nhóm data
library(dplyr)
Nest <- split(data, data$Nest)
Nest[['AutavauxTV']]


# Vẽ biểu đồ
plot(x = Nest[["AutavauxTV"]]$SiblingNegotiation,
     y = Nest[["AutavauxTV"]]$ArrivalTime, 
     xlab = "Sibling Negotiation",
     ylab = "Arrival Time", 
     main = "AutavauxTV")


plot(x = Nest[["Bochet"]]$SiblingNegotiation, 
     y = Nest[["Bochet"]]$ArrivalTime,
     xlab = "Sibling Negotiation",
     ylab = "Arrival Time",
     main = "Bochet")


plot(x = Nest[["CorcellesFavres"]]$SiblingNegotiation, 
     y = Nest[["CorcellesFavres"]]$ArrivalTime,
     xlab = "Sibling Negotiation",
     ylab = "Arrival Time",
     main = "CorcellesFavres")



# Câu 2:
# Filter data with multiple condition in group
data[data$Nest == "AutavauxTV" & data$FoodTreatment == "Deprived",]
