

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
str(weather)

# Xem ten col 
names(weather)

# Loc dieu kien: Origin = EWR, month = 1, day < 15
EWR <- filter(weather, weather$origin == "EWR" & (weather$month == 1 & weather$day < 15))

plot <- EWR %>%
  ggplot(aes(x = time_hour,
             y = temp)) +
  geom_line(color="purple", size = 1) +  
  theme_bw() + 
  labs(title = 'Newark Liberty Intl',
       x = "Time Hour",
       y = "Temp") +
  theme(axis.text.x = element_text(vjust = 0.5),
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
