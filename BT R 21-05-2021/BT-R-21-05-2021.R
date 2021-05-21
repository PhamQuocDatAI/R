
# Setup thu muc hien hanh 
setwd("c:\\Users\\PC\\Desktop\\R\\BT R 21-05-2021")

# Load dataset
data <- read.csv("RIKZ2.txt", sep = '\t', header = TRUE)

# Bai tap
# 7.3 Boxplot su dung cho du lieu sinh vat bien RIKZ2.txt 
# Ve bieu do Boxplot giua Richness ~ Beach

par(mfrow= c(2,2), mar= c(3,3,2,1))
boxplot(data$Richness)
boxplot(data$Beach)
boxplot(Richness ~ Beach, data = data,
        xlab = "Richness",
        ylab = "Beach",
        main = "Relation between Richness and Beach",
        col = "orange",
        border = 'brown',
        horizontal = FALSE)



