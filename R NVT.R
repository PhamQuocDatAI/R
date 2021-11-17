


# Cai dat thu muc lam viec
setwd("C:/Users/ASUS/OneDrive/Máy tính/R")

# Load dataset 
data <- read.table("igf.txt", header = TRUE)
data

# Xem thong tin du lieu 
names(data)
str(data)

# Tach roi du lieu 
## a. subset()
male = subset(data, sex == "Male")
male

## b. Su dung filter() tu thu vien dplyr
library(dplyr)
female = filter(data, sex == "Female")
female

# Chiet so lieu tu mot dataframe
## Lay du lieu 3 cot dau tien 
data2 <- data[, c(1, 2, 3)]
data2

# Nhap 2 dataframe thanh mot. 
data3 <- merge(female, male, by = "id", all = TRUE)
data3

# Bien doi du lieu 
## a. 
point <- sample(c(rep(3, 7), 
                  rep(5, 3),
                  rep(9, 9),
                  rep(10, 4),
                  rep(6.5, 7)))
point                
lettergrade <- point
lettergrade[point <  5] <- "D"
lettergrade[point > 5 & point <=  6.5] <- "C"
lettergrade[point > 6.5 & point <= 8.5] <- "B"
lettergrade[point >= 8.5] <- "A"
point <- data.frame(point, lettergrade)
point

## b. Su dung replace()
