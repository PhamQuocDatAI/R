

setwd("C://Users//PC//Desktop//R")

# plot()
Benthic <- read.table("RIKZ2.txt", sep = "\t", header = TRUE)
plot(Benthic$Richness)

# lines()
?lines
lines(Benthic$Richness)

# order()
a <- c(5, 1, 6, 8, 9, -4, 7, 7, 4)
order(a)

# loess()
?loess

# fitted()
?fitted
