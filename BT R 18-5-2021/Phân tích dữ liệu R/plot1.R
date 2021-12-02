
setwd("C:/Users/ASUS/Desktop/R/Phân tích d??? li???u R")

library(nycflights13)
library(ggplot2)
library(plotly)
library(dplyr)

# Dataset
data("airlines")
data("airports")
data("flights")
data("planes")
data("weather")

# Xem du lieu cua tung col trong dataset
str(flights)

# Xem ten col 
names(flights)

# Loc nhung chuyen bay cua hang Alsska Airlines Inc
AA <- filter(flights, flights$carrier == "AA")

# Xu li du lieu: loc NA value,...
AA <- na.omit(AA)

# Thong tin ve cac col

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' dep_time = departure_time = thoi gian khoi hanh
#' sched_dep_time = schedule departure time = thoi gian khoi hanh da len lich san
#' dep_delay = departure delay = thoi gian cho khoi hanh
#' arr_delay = arrange delay 
#' carrier = 
#' flight = chuyen bay 
#' Origin = noi khoi hanh
#' Dest = diem ha canh
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Ve bieu do 
# Lay 1000 row 
AA_1k <- AA[1:1000,]
AA_1k
plot <- ggplot(AA_1k, aes(dep_delay,
                       arr_delay,
                       fill = origin, size = hour)) +
  geom_point() + 
  theme_bw() + 
  labs(title = 'Alsska Airlines Inc') +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        plot.title = element_text(hjust = 0.5, size = 18),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill="lightblue",
                                         size=0.5, linetype="solid", 
                                         colour ="darkblue"),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(plot, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


