
# Chuyen sang thu muc lam viec
setwd('C:/Users/ASUS/OneDrive/Máy tính/crawler')

# Khai bao thu vien 
library(ggplot2)
library(plotly)
library(gapminder)
library(tidyverse)
library(viridis)
library(hrbrthemes)
library(dplyr)
library(plyr)
library(readr)

# Nhap du lieu 
my_file <- list.files(pattern = "*.csv")
data <- ldply(my_file, read_csv)

# Xem du lieu 
head(data, 10)
names(data)
str(data)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Xu li du lieu 
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

data$time_up <- as.Date(data$time_up, "%d/%m/%Y")
cols <- c("trademark", "brand", "style", "fuel")
data[cols] <- lapply(data[cols], factor)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Phan tich thong ke mo ta
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# summary
summary(data)

# table
table(data$trademark)    # So luong xe cua moi hang dang duoc rao ban
table(data$style)    # Phân khúc xe dang duoc rao ban
table(data$box_car)    # Hop so xe
table(data$local)    # Tinh thanh ban xe
table(data$year_product)    # Nam san xuat xe

# mean

# quantile
quantile(data$price)    # Tu phan vi gia xe
quantile(data$KM)    # Tu phan vi so km da di 

# correlation
cor(data[c(5, 6, 10)], use = "everything", method = "pearson")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Ve bieu do 
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Demo
# Hist
hist(data$price)

hist(data$year_product)

hist(data$KM)

# Pie 
table(data$trademark)
pie(table(data$trademark))

pie(table(data$style))

# Bar 
barplot(table(data$trademark))

table(data$status, data$trademark)
barplot(table(data$status, data$trademark), beside = TRUE)

table(data$origin, data$trademark)
barplot(table(data$origin, data$trademark))

table(data$box_car, data$style)
barplot(table(data$box_car, data$style), beside = TRUE)

table(data$fuel, data$trademark)
barplot(table(data$fuel, data$trademark))

# Box plot
boxplot(data$trademark ~ data$status)

boxplot(data$trademark ~ data$fuel)

boxplot(data$trademark ~ data$origin)

boxplot(data$style ~ data$status)

plot(data$trademark, data$price) 

# Scatter plot

plot(data$price, data$KM) 

plot(data$year_product, data$KM) 

# Loc xe moi, xe cu -> Ve bieu do 
new_car <- filter(data, data$status == "M???i")
old_car <- filter(data, data$KM != 0)

# Loc theo hang xe -> ve bieu do
Mer <- filter(data, data$trademark == "Mercedes-Benz")
Audi <- filter(data, data$trademark == "Audi")
LandRover <- filter(data, data$trademark == "Land Rover")

# Loc theo phan khuc xe -> ve bieu do
Sedan <- filter(data, data$style == "Sedan")
SUV <- filter(data, data$style == "SUV")
CUV <- filter(data, data$style == "CUV")
MPV <- filter(data, data$style == "MPV")
