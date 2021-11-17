



setwd("C:/Users//ASUS/Desktop/R/Phân tích d??? li???u R/R-book-master")

igf <- read.table("igf.txt", header = TRUE)
names(igf)
str(igf)

igf <- na.omit(igf)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Vi du 9: 
#' a. Tinh mean cua cot age
#' b. Tinh variance, standare deviation cot age
#' c. Tinh sai so chuan (Standare Error = s/sqrt(n))
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# a
mean(igf$age)

# b
var(igf$age)
sd(igf$age)

# c
# Tao ham tinh SE
SE <- function(x) {
  SD <- sd(x)
  n <- length(x)
  result <- SD/sqrt(n)
  return(result)
}
SE(igf$age)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Vi du 10: Kiem dinh t mot mau 
#' p_value < significance level: bac bo H0
#' p_value > significance level: chap nhan H0
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

age <- igf$age
t.test(age, mu=30)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Vi du 11: Qua phan tich mo ta, chung ta thay phu nu co do hormone igfi cao hon 
#' gioi (167.97 va 160.29). Co su khac biet co he thong hay do cac yeu to ngau 
#' nhien gay ra?
#'
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

igfi <- igf$igfi
# Kiem dinh voi gia thiet 2 nhom khac phuong sai 
t.test(igfi~ igf$sex)

# Kiem dinh voi gia thiet 2 nhom cung phuong sai 
t.test(igfi~ igf$sex, var.equal = TRUE)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#'
#' Vi du 12: Kiem dinh t cho cac bien so theo cap (paired t-test, t.test)
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Nhap du lieu:
before <- c(180, 140, 160, 160, 220, 185, 145, 160, 160, 170)
after <- c(170, 145, 145, 125, 205, 185, 150, 150, 145, 155)
data <- data.frame(before, after)

# Kiem dinh t cho tung cap 
t.test(before, after, paired=TRUE)

# Kiem dinh Wilcoxon cho cac bien so theo cap 
wilcox.test(before, after, paired=TRUE, method="greater")

# Kiem dinh t cho 2 nhom doc lap
t.test(before, after)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#'
#' Kiem dinh ti le (proportion test, prop.test, binom.test)
#' Vi du 13: Trong nghien cuu tren, chung ta co 69 nu va 31 nam. Nhu vay ti le 
#' nu la 0.69. Kiem dinh xem ti le nay co that su khac voi ti le 0.5 hay khong
#'
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

prop.test(69, 100, 0.50)

# Kiem dinh nhi phan binom.test
binom.test(69, 100, 0.50)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#'
#' Vi du 14: 
#'
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

fracture <- c(7, 20)
total <- c(100, 110)
prop.test(fracture, total)

# So sanh nhieu ti le 
ethnicity <- igf$ethnicity
sex <- igf$sex
table(sex, ethnicity)
female <- c( 4, 43, 22, 0)
total <- c(8, 60, 30, 2)
prop.test(female, total)

# Kiem dinh Fisher
prop.test(female, total)
