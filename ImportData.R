# Import Data

setwd("C:/Users/PC/Desktop/Bài tập R")
squid <- read.table("squid.txt", header = TRUE)
squid1 <- read.table("squid1.txt", header = TRUE)
squidGSI <- read.table("squidGSI.txt", header = TRUE)
Deer <- read.table("Deer.txt", header = TRUE)

library("readxl")
BirdFlu <- read_excel("BirdFlu.xls")
ISIT <- read.table("ISIT.txt", header = TRUE)
ARK <- read.table("Amphibian_road_Kills.csv", header =  TRUE)
