



ipod <- sample(c(rep(1, 250),
                 rep(2, 300),
                 rep(3, 600),
                 rep(4, 800),
                 rep(5, 550),
                 rep(6, 350),
                 rep(7, 100),
                 rep(8, 25),
                 rep(9, 20),
                 rep(10, 5)))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' L???y ra m???u có kích thu???c b???ng 25 (m???u g???m 25 bài hát). L???p l???i vi???c l???y m???u 
#' 50 l???n. 
#' a. V??? ra bi???u d??? t???n su???t xu???t hi???n c???a các bài hát có d??? dài t??? 1 d???n 10 phút
#' b. Tính xác su???t xu???t hi???n nh???ng bài hát có d??? dài t??? 6 phút tr??? di. 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# a
result <- c()
for (x in 1:50) {
  sp <- sample(ipod, 25)
  result <- c(result, sp)
}
result 
hist(result)
value <- data.frame(result)
library(ggplot2)
library(plotly)

plot <- value %>%
  ggplot(aes(x = result)) + 
  geom_histogram(fill = "#FBF4E9", color="#6ECB63", alpha=1, bins = 10) + 
  labs(title = "Sample", 
       x = "Value", 
       y = "Count") + 
  theme_bw() + 
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

# b
up6 <- filter(value, value$result >= 6)
up6
result <- length(up6$result)/length(value$result)
result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' L???y ra m???u có kích thu???c b???ng 25 (m???u g???m 25 bài hát) - L???p l???i vi???c l???y m???u
#' 500 l???n. V??? ra bi???u d??? t???n su???t xu???t hi???n c???a các bài hát có d??? dài 
#' t??? 1 d???n 10 phút
#' Tính xác su???t xu???t hi???n nh???ng bài hát có d??? dài t??? 6 phút tr??? di.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# a
result <- c()
for (x in 1:500) {
  sp <- sample(ipod, 25)
  result <- c(result, sp)
}
result 
hist(result)
value <- data.frame(result)
library(ggplot2)
library(plotly)

plot <- value %>%
  ggplot(aes(x = result)) + 
  geom_histogram(fill = "#FBF4E9", color="#6ECB63", alpha=1, bins = 10) + 
  labs(title = "Sample", 
       x = "Value", 
       y = "Count") + 
  theme_bw() + 
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

# b
up6 <- filter(value, value$result >= 6)
up6
result <- length(up6$result)/length(value$result)
result
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' L???y ra m???u có kích thu???c b???ng 30 (m???u g???m 30 bài hát) - L???p l???i vi???c l???y m???u 
#' 30 l???n. V??? ra bi???u d??? t???n su???t xu???t hi???n c???a các bài hát có d??? dài 
#' t??? 1 d???n 10 phút
#' Tính xác su???t xu???t hi???n nh???ng bài hát có d??? dài t??? 6 phút tr??? di.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# a
result <- c()
for (x in 1:30) {
  sp <- sample(ipod, 30)
  result <- c(result, sp)
}
result 
hist(result)
value <- data.frame(result)
library(ggplot2)
library(plotly)

plot <- value %>%
  ggplot(aes(x = result)) + 
  geom_histogram(fill = "#FBF4E9", color="#6ECB63", alpha=1, bins = 10) + 
  labs(title = "Sample", 
       x = "Value", 
       y = "Count") + 
  theme_bw() + 
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

# b
up6 <- filter(value, value$result >= 6)
up6
result <- length(up6$result)/length(value$result)
result

