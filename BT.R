setwd("C:/Users/PC/Desktop/R")
Farm <- c("MO", "MO", "MO", "MO", "LN", "SE", "QM")
Month <- c(11, 7, 7, NA, 9, 9, 11)
Year <- c(0, 0, 1, NA, 3, 3, 2)
Sex <- c(1, 2, 2, 2, 1, 2, 2)
LengthClass <- c(1, 1, 1, 1, 1, 1, 1)
LengthCT <- c(75, 85, 91.6, 95, NA, 105.5, 106)
Ecervi <- c(0, 0, 0, NA, 0, 0, 0)
Tb <- c(0, 0, 1, NA, 0, 0, 0)
mean(LengthCT, na.rm = TRUE)


Boar <- cbind(Month, LengthCT, Tb)
dim(Boar)
nrow(Boar)
ncol(Boar)


Matrix <- cbind(c(1, 4, 2), c(2, 2, 3), c(3, 1, 0))
Inverse_M <- solve(Matrix)
Transpose <- t(Matrix)
Mul <- Matrix %*% Inverse_M
