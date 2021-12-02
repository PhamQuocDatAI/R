


# Tao data
ID <- c(1:18, 1:14)
group <- c(rep(1, 18), rep(2, 14))
Group <- group
Group[group == 1] <- "Urban"
Group[group == 2] <- "Rural"
Group <- as.factor(Group)
Age <- c(109, 113, 115, 116, 119, 120, 121, 124, 126, 129,
         130, 133, 134, 135, 137, 139, 141, 142, 121, 121, 
         128, 129, 131, 132, 133, 134, 138, 138, 138, 140,
         140, 140)
Height <- c(137.6, 147.8, 136.8, 140.7, 132.7, 145.4, 135.0, 133.0, 148.5,
            148.3, 147.5, 148.8, 133.2, 148.7, 152.0, 150.6, 165.3, 149.9,
            139.0, 140.9, 134.9, 149.5, 148.7, 131.0, 142.3, 139.9, 142.9,
            147.7, 147.7, 134.6, 135.8, 148.5)
data <- data.frame(Group, ID, Age, Height)
data

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Kiem dinh chung minh co su khac biet ve do tuoi giua hai nhom hoc sinh
#' Ta co phuong trinh hoi quy 
#' y = alpha + beta*x + gamma*g + sigma*(xg) + e
#' Voi beta: Age, gamma = Group, sigma = (Age, Group)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

model1 <- lm(Height ~ Group + Age + Group:Age)
model2 <- lm(Height ~ Group + Age)
model3 <- lm(Height ~ Age)
anova(model1, model2, model3)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Nhan xet
#' Mo hinh 1 khong danh gia duoc kiem dinh 
#' Mo hinh 2 voi p_valua = 0.23251 > 0.05: Bac bo gia thiet H0 co nghia la co su 
#' khac biet ve do tuoi giua 2 nhom hoc sinh
#' Mo hinh 3 voi p_value < 0.05 Khong du bang chung de bac bo gia thiet H0
#' Ket luan: Chung ta chon mo hinh 2 de phan tich
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

summary(model2)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Phan tich mo hinh 2 
#' Phuong trinh tuyen tinh la:
#' y = alpha + beta*x + gamma*g + e
#' Doi voi nhom 1: nong thon
#' y = 86.3508 + 0.4157(Age)
#' Doi voi nhom 2: thanh thi
#' y = 86.3508 + 0.4157(Age) + 5.4663(Urban)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


