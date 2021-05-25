
# setwd()
setwd("C://Users//PC//Desktop//R//BT R t???ng h???p")

# read.table()
Benthic <- read.table("RIKZ2.txt", sep = "\t", header = TRUE)

# median()
x <- sort(Benthic$Richness, decreasing = FALSE)
x[23]
median(Benthic$Richness)

# max()
max(Benthic$Richness)

# min()
min(Benthic$Richness)

# c()
a <- c(1, 2, 3, 4, 5, 6)
a
b <- c("A", "B", "C", "D", "E")
b
c <- c("ABC", "ac", 1, 222, 333, "djash", 1212)
c

# cbind()
d <- cbind(a, b, c)
d

# rbind()
# rbind data.frame with vector
a1 <- c(1, 2, 3)
a2 <- c(2, 3, 4)
a3 <- c(3, 4, 5)
a4 <- c(3, 4, 5, 6)
df <- data.frame(a1, a2, a3)
rbind(df, a4)

# rbind 2 data.frame
df2 <- data.frame(a2, a3, a1)
df2
rbind(df, df2)

# rbind with missing value
library("plyr")
col1 <- c(5, 1, 1, 8)                
col2 <- c(9, 7, 5, 1)                
col3 <- c(1, 1, 2, 2) 
data_plyr1 <- data.frame(col1, col2, col3)

col3 <- c(5, 1, 1, 8)           
col4 <- c(9, 7, 5, 1)      
data_plyr2 <- data.frame(col3, col4)

rbind.fill(data_plyr1, data_plyr2)

# vector()

df <- data.frame(x=1:3, y=5:7)
## Not run: 
## Error:
as.vector(data.frame(x=1:3, y=5:7), mode="numeric")
## End(Not run)

x <- c(a = 1, b = 2)
is.vector(x)
as.vector(x)
all.equal(x, as.vector(x)) ## FALSE

###-- All the following are TRUE:
is.list(df)
! is.vector(df)
! is.vector(df, mode="list")

is.vector(list(), mode="list")
is.vector(NULL,   mode="NULL")

# matrix()
matrix(data = c(1, 2, 3, 4), nrow = 2, ncol = 2)

# data.frame()

emp.data <- data.frame(
  emp_id = c (1:5), 
  emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
  salary = c(623.3,515.2,611.0,729.0,843.25), 
  
  start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
                         "2015-03-27")),
  stringsAsFactors = FALSE)
		
print(emp.data)

# list()

list_data <- list("Red", "Green", c(21,32,11), TRUE, 51.23, 119.1)
print(list_data)

# rep()

rep(2, 3)

# seq()
x <- seq(-6,7)
x

y <- seq(-6,7,by=2)
y

z <- seq(-2,2,by=0.3)
z

seq(-2,2,length.out=10)

x <- c(1,3,"f",5,3)
seq(1,10,along.with=x)

# dim()
dim(Benthic)

# colnames()
colnames(Benthic)

# rownames
rownames(Benthic)

# scan()

scan(Benthic)
# R Program to scan a file

# Create example data.frame
data <- data.frame(x1 = c(1, 2, 2, 3),				
                   x2 = c(4, 5, 6, 7),
                   x3 = c(8, 9, 10, 11))
data

# Write data as txt file to directory
write.table(data,					
            file = "data.txt",
            row.names = FALSE)

# Get currently used directory
getwd()

# Apply scan function to txt file
data <- scan("data.txt", what = "character")
data
