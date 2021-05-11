setwd("c:/Users/PC/Desktop/R")

# Import data
data = read.table("Owls.txt", header = TRUE)


# EX1:
# Use library(dplyr) to split data
library(dplyr)
Nest <- split(data, data$Nest)
Nest[['AutavauxTV']]


# Draw plot
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



# EX2:
# Filter data with multiple condition in group
data[data$Nest == "AutavauxTV" & data$FoodTreatment == "Deprived", ]



        
}






