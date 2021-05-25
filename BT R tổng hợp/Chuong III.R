

setwd("C://Users//PC//Desktop//R//BT R t???ng h???p")

# write.table()
?write.table


# order()
y = c(4,12,6,7,2,9,5)
order(y)

y = c(4,12,6,7,2,9,5)
y[order(y)]

# merge()
?merge

authors <- data.frame(
  surname = c("Tukey", "Venables", "Tierney", "Ripley", "McNeil"),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  retired = c("yes", rep("no", 4)))
books <- data.frame(
  name = c("Tukey", "Venables", "Tierney", "Ripley", "Ripley", "McNeil"),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA))

merge(authors, books, by.x="surname", by.y="name")
merge(books, authors, by.x="name", by.y="surname")

# attach()

data <- data.frame(x1 = c(9, 8, 3, 4, 8),         
                   x2 = c(5, 4, 7, 1, 1),
                   x3 = c(1, 2, 3, 4, 5))
data       
attach(data)  
x1
x2

# str()

Benthic <- read.csv("RIKZ2.txt", sep = "\t", header = TRUE)
str(Benthic)

# factor()
factor(Benthic$Richness)
