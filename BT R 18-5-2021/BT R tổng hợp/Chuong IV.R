

setwd("C://Users//PC//Desktop//R//BT R t???ng h???p")

# tapply()

x<-runif(20, min=155, max=180) 
x
y<-gl(2, 10, labels = c("Male", "Female")) 
y
tapply(x, y, mean)

# sapply()

Benthic <- read.table("RIKZ2.txt", sep = "\t", header = TRUE)
sapply(Benthic, min)

# sd()
?sd
sd(Benthic$Richness)

# length
length(Benthic$Richness)

# summary()
?summary
summary(Benthic$Richness)

# table()
?table

