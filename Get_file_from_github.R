
# Cach de lay duoc file csv tu github
# Su dung thu vien readr
library(readr)


# Lay file raw tu github
urlfile = "https://raw.githubusercontent.com/pandas-dev/pandas/master/doc/data/air_quality_long.csv"


# Lay data ve
data <- read_csv(url(urlfile))
data


# Ghi du lieu vao file csv
write.csv(data, "air_quality_long.csv")
