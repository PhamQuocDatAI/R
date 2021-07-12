
# Cach de lay duoc file csv tu github
# Su dung thu vien readr

setwd("C://Users//PC//Desktop//T??? h???c//RStudio")
library(readr)


# Lay file raw tu github
urlfile = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-20-2021.csv"


# Lay data ve
data <- read_csv(url(urlfile))



# Ghi du lieu vao file csv
write.csv(data, "02-20-2021.csv")

