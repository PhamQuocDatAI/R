

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#'
#'                                  DO AN R
#'                                
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("C://Users//PC//Desktop//Daily_report")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#'
#'Khai bao cac thu vien
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(ggplot2)
library(plotly)
library(gapminder)
library(forcats)
library(wesanderson)
library(tidyverse)
library(babynames)
library(viridis)
library(hrbrthemes)
library(dplyr)
library(plyr)
library(readr)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#'
#' Load dataset
#' Covid-19/csse_covid_19_data/csse_covid_19_daily_report_us
#' 01-01-2021
#'   
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  


covid <- read.csv("C://Users//PC//Desktop//Ð??? ÁN R//COVID//COVID-2021-daily-report-US//01-01-2021.csv")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#'
#' Load dataset
#' Covid-19/csse_covid_19_data/csse_covid_19_daily_reports
#' 01-01-2021 -> 20-02-2021
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


my_file <- list.files(pattern = "*.csv")
covid_2months = ldply(my_file, read_csv)
US <- filter(covid_2months, covid_2months$Country_Region == "US")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#'
#' Loc du lieu
#' Xoa bo cot People_Hospitalized, Hospitalization_Rate
#' Xoa bo NA value
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


covid <- subset(covid, select = -c(People_Hospitalized, Hospitalization_Rate))
covid <- na.omit(covid)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' PLot 1: Case Fatality Ratio of Province in US
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

p1 <- covid %>%
  mutate(Province = fct_reorder(Province_State, Case_Fatality_Ratio)) %>%
  ggplot( aes(x = Province, y = Case_Fatality_Ratio,)) +
  geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
  labs(title = "Case Fatality Ratio of Province in US",
       x = "",
       y = "Case Fatality Ratio") + 
  coord_flip() +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5), 
        panel.background = element_rect(fill = 'white'), 
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(p1, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 2: Testing Rate per 100000 human
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

p2 <- covid %>%
  mutate(Province = fct_reorder(Province_State, Testing_Rate)) %>%
  ggplot( aes(x = Province, y = Testing_Rate)) +
  geom_bar(stat="identity", fill= "#FF6600", alpha=.6, width=.4) +
  labs(title = "Total test results per 100,000 persons in US",
       x = "",
       y = "Testing Rate") + 
  coord_flip() +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5), 
        panel.background = element_rect(fill = "white"),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(p2, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 3: Relationship between Active and Confirmed human in US
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

p3 <- ggplot(covid, aes(Confirmed, Active,
                        colour = Active, fill = Province_State, size = Active)) +
  geom_point() + 
  geom_smooth(method = 'loess', formula = 'y ~ x',
              fill = '#CC6600',colour = '#990099') + 
  theme_bw() + 
  labs(title = 'Relationship between Active and Confirmed human in US') +
  theme(plot.title = element_text(hjust = 0.5),
        legend.background = element_rect(fill="lightblue",
                                         size=0.5, linetype="solid", 
                                         colour ="darkblue"),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5)) +
  guides(colour = FALSE)
  
ggplotly(p3, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 4 : Relationship between Deaths and Confirmed in US
#' Mo ta 
#' PLot chia thanh 4 khu vuc
#' Phan tu thu 1: So dan it nhung ti le chet cao -> Rat nguy hiem 
#' Phan tu thu 2: So dan dong, ti le chet cao -> Nguy hiem cao
#' Phan tu thu 3: So dan dong, ti le chet thap -> Nguy hiem trung binh
#' Phan tu thu 4: So dan it, it nguoi chet -> Nguy hiem thap 
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

p4 <- ggplot(covid, aes(Confirmed, Deaths, 
                        colour = Deaths, size = Deaths, text = Province_State)) +
  geom_point() + 
  geom_smooth(method = lm, formula = y~x, 
              fill = '#CC6600',colour = '#990099') + 
  geom_hline(yintercept=10000, color="orange", size=1) + 
  geom_vline(xintercept=500000, color="orange", size=1) +
  theme_bw() + 
  labs(title = 'Relationship between Deaths and Confirmed in US') +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(p4, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 5: 
#' Tinh tong cac chi so Confirmed, Deaths, Recovered, Active
#' Ve bieu do 
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

slice <- covid[, c(1, 6, 7, 8, 9)]
total <- colSums(slice[,-1])
total <- data.frame(total)
total <- cbind(rownames(total), total)
rownames(total) <- 1:nrow(total)
colnames(total) <- c("Var", "Count")


p5 <- total  %>% 
  mutate(name = fct_reorder(Var, Count)) %>%
  ggplot(aes(y = name, x = Count, fill = Var, text = Var)) +
  geom_bar(stat="identity", width = 0.5) + 
  coord_flip() +
  theme_bw() +
  labs(title = "Total Confirmed, Deaths, Recovered, Active in US",
       y = "",
       fill = "") + 
  theme(plot.title = element_text(hjust = 0.5),
        legend.background = element_rect(fill="lightblue",
                                         size=0.5, linetype="solid", 
                                         colour ="darkblue"),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(p5) %>%
  rangeslider() %>%
  layout(hovermode = "x")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 6: 
#' Thanh pho New York, Ohio, Michigan
#' Tuong quan giua Death va Confirmed trong 2 thang (01-01-2021 -> 21-02-2021)
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

some_provin <- filter(US, US$Province_State == c("New York",
                                              "Washington",
                                              "Michigan", 
                                              "Mississippi"))
some_provin$Last_Update <- as.Date(some_provin$Last_Update)
some_provin$Last_Update <- as.factor(some_provin$Last_Update)

p6 <-  some_provin %>% 
  ggplot(aes(x=Confirmed, y=Deaths, fill = Last_Update, text = Province_State)) +
  geom_area() +
  scale_fill_viridis(discrete = TRUE) +
  labs(title = "Deaths and Confirmed in some province, US (2 months)",
       fill = "Time") +
  theme_ipsum() + 
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 16, hjust = 0.5),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill="lightblue",
                                         size=0.5, linetype="solid", 
                                         colour ="darkblue"),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(p6, tooltip="text", dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 7: 
#' So thanh pho co so ca tu vong tren 4000 nguoi o US
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Over4000 <- filter(US, US$Deaths > 4000)
Over4000$Last_Update <- as.Date(Over4000$Last_Update)

p7 <- Over4000 %>%
  ggplot(aes(Deaths, fill = Province_State, text = Last_Update)) +
  geom_density( alpha = 0.85) + 
  labs(title="City with over 4000 deaths human in US", 
       caption = "Source: mpg", 
       x = "Deaths", 
       fill = "Province State") + 
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.6),
        plot.title = element_text(hjust = 0.5), 
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill="lightblue",
                                         size=0.5, linetype="solid", 
                                         colour ="darkblue"),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(p7, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 8: 
#' Nhung quoc gia co so nguoi tu vong tren 30000
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Over30k <- filter(covid_2months, covid_2months$Deaths > 30000)
Over30k$Last_Update <- as.Date(Over30k$Last_Update)

p8 <- Over30k %>%
  ggplot(aes(Country_Region, Deaths)) +
  geom_boxplot(aes(fill = factor(Country_Region))) + 
  labs(title="Country with deaths over 30000 deaths human", 
       caption = "Source: mpg", 
       x = "COVID19", 
       fill = "Province State") + 
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(hjust = 0.5), 
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill="lightblue",
                                         size=0.5, linetype="solid", 
                                         colour ="darkblue"),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(p8, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 9: 
#' Thieu title, border, ....
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


ax <- list(
  zeroline = TRUE,
  showline = TRUE,
  mirror = "ticks",
  gridcolor = toRGB("gray50"),
  gridwidth = 2,
  zerolinecolor = toRGB("red"),
  zerolinewidth = 4,
  linecolor = toRGB('black'),
  linewidth = 3.5)



Vietnam <- filter(covid_2months, covid_2months$Country_Region == "Vietnam")
Vietnam$Last_Update <- as.Date(Vietnam$Last_Update)


p9 <- Vietnam %>%
  plot_ly(x = ~Last_Update, y = ~ Active,
          type = 'bar',
          name = 'Active', 
          marker = list(color = 'rgb(55, 83, 109)'))

p9 <- p9 %>% 
  add_trace(y = ~ Deaths, 
            name = 'Deaths',
            marker = list(color = 'rgb(26, 118, 255)'))

p9 <- p9 %>% 
  layout(title = "Death and Active in Viet Nam",
         xaxis = ax,
         yaxis = ax,
         margin = list(b = 100),
         barmode = 'group',
         paper_bgcolor = 'rgb(248, 248, 255)',
         plot_bgcolor = 'rgb(248, 248, 255)')



ggplotly(p9, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 10: So mau xet nghiem cua cac tinh, thanh pho o US
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

p10 <- covid %>%
  ggplot( aes(x=Province_State, y=Total_Test_Results,
              fill = Province_State, size = Total_Test_Results)) +
  geom_point(alpha=0.7) +
  scale_size(range = c(1.4, 19)) +
  scale_color_viridis(discrete=TRUE, guide=FALSE) +
  theme_ipsum() +
  labs(x = "Province", y = "Total Test Results",
       y = "",
       title = "Total Test Result in US",
       fill = "") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        plot.title = element_text(hjust = 0.5, size = 18),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill="lightblue",
                                         size=0.5, linetype="solid", 
                                         colour ="darkblue"),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))

ggplotly(p10, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 11:
#' 
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

data <- total[2:4,]


colors <- c('rgb(144,103,167)',
            'rgb(171,104,87)',
            'rgb(114,147,203)')

p11 <- data %>%
  plot_ly(labels = ~ Var, values = ~ Count, type = 'pie',
          textposition = 'inside',
          textinfo = 'label+percent',
          insidetextfont = list(color = '#FFFFFF'),
          hoverinfo = 'text',
          text = ~paste(Count, 'human'),
          marker = list(colors = colors,
                        line = list(color = '#000000', width = 2)),
          showlegend = TRUE)

p11 <- p11 %>% 
  layout(title = 'COVID 19',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

ggplotly(p11)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 12:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

p12 <- plot_ly(covid, x = ~Recovered, y = ~Province_State,
               name = "Recovered", type = 'scatter',
               mode = "markers", marker = list(color = "#990000"))
p12 <- p12 %>% add_trace(x = ~Deaths, y = ~Province_State, 
                         name = "Deaths",type = 'scatter',
                         mode = "markers", marker = list(color = "FFCC99"))
p12 <- p12 %>% add_trace(x = ~Active, y = ~Province_State,
                         name = "Active",type = 'scatter',
                         mode = "markers", marker = list(color = "#33CCFF"))
p12 <- p12 %>% layout(
  title = "Recovered - Deaths - Active",
  xaxis = list(title = "Count"),
  yaxis = list(title = "Province"),
  margin = list(l = 100)
)

ggplotly(p12, dynamicTicks = TRUE) %>%
  rangeslider() %>%
  layout(hovermode = "x")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 13:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("C://Users//PC//Desktop//Ð??? ÁN R//COVID//COVID-2021-daily-report-US")

# read csv from url
df1 = read.csv('01-01-2021.csv')
df2 = read.csv('01-08-2021.csv')
df3 = read.csv('01-15-2021.csv')
df4 = read.csv('01-22-2021.csv')
df5 = read.csv('01-29-2021.csv')

Province_state = df1[1:15,'Province_State']
D01_1 = df1[1:15,'Deaths']
D08_1 = df2[1:15,'Deaths']
D15_1 = df3[1:15,'Deaths']
D22_1 = df4[1:15,'Deaths']
D29_1 = df5[1:15,'Deaths']


data = data.frame(Province_state,D01_1,D08_1,D15_1,D22_1,D29_1) 
data
# order factor levels by men's income (plot_ly() will pick up on this ordering)
data$Province_state <- factor(data$Province_state, levels = data$Province_state[order(data$D01_1)])

p13 <- plot_ly(data, color = I("gray80"))

p13 <- p13 %>% add_segments(x = ~D01_1, xend = ~D08_1,
                            y = ~Province_state, yend = ~Province_state,
                            showlegend = FALSE)

p13 <- p13 %>% add_segments(x = ~D08_1, xend = ~D15_1,
                            y = ~Province_state, yend = ~Province_state,
                            showlegend = FALSE)

p13 <- p13 %>% add_segments(x = ~D15_1, xend = ~D22_1,
                            y = ~Province_state, yend = ~Province_state,
                            showlegend = FALSE)

p13 <- p13 %>% add_segments(x = ~D22_1, xend = ~D29_1,
                            y = ~Province_state, yend = ~Province_state,
                            showlegend = FALSE)


p13 <- p13 %>% add_markers(x = ~D01_1, y = ~Province_state, name = "Day 01-1-2021", color = I("pink"))
p13 <- p13 %>% add_markers(x = ~D08_1, y = ~Province_state, name = "Day 08-1-2021", color = I("blue"))
p13 <- p13 %>% add_markers(x = ~D15_1, y = ~Province_state, name = "Day 15-1-2021", color = I("red"))
p13 <- p13 %>% add_markers(x = ~D22_1, y = ~Province_state, name = "Day 22-1-2021", color = I("cyan"))
p13 <- p13 %>% add_markers(x = ~D29_1, y = ~Province_state, name = "Day 29-1-2021", color = I("gray"))
p13 <- p13 %>% layout(
  title = "Increase Deaths after 7 day of Province State ",
  xaxis = list(title = "Count"),
  yaxis = list(title = "Province"),
  margin = list(l = 65))

ggplotly(p13) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 14:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


f <- list(
  family = "Courier New, monospace",
  size = 18,
  color = "#7f7f7f")

x <- list(zeroline = TRUE,
          showgrid = FALSE,
          linecolor = toRGB('black'),
          linewidth = 3,
          titlefont = f)

y1 <- list(title = "Case Fatality Ratio",
           zeroline = TRUE,
           showgrid = TRUE,
           linecolor = toRGB('black'),
           linewidth = 1.5,
           titlefont = f, 
           range = c(0, 15))

y2 <- list(title = "Case per 100000 human",
           linecolor = toRGB('black'),
           linewidth = 1.5,
           titlefont = f,
           tickfont = list(colour = "red"),
           overlaying = "y",
           side = "right",
           titlefont = f, 
           range = c(0, 15))


p14 <- plot_ly(covid, y = ~Case_Fatality_Ratio, x = ~ Province_State, 
               type = 'scatter', 
               mode = 'lines',
               name = "Case Fatality Ratio",
               labels = ~ Province_State, values = ~ Case_Fatality_Ratio,
               textposition = 'inside',
               textinfo = 'label+percent',
               hoverinfo = 'text',
               text = ~paste(Case_Fatality_Ratio, '%'),
               marker = list(colors = colors,
                             line = list(color = '#000000', width = 2)),
               showlegend = TRUE)

p14 <- p14 %>%
  add_trace(y = ~ Incident_Rate/1000, 
            type = 'scatter',
            mode = 'lines+markers',
            name = 'Case per 100000 human', 
            yaxis = "y2")

p14 <- p14 %>%
  layout(xaxis = x, yaxis = y1, yaxis2 = y2, 
         title = "COVID19 in US 01-01-2021")

ggplotly(p14) %>%
  rangeslider() %>%
  layout(hovermode = "x")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 15:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


f <- list(
  family = "Courier New, monospace",
  size = 18,
  color = "#7f7f7f")

x <- list(zeroline = TRUE,
          showgrid = FALSE,
          linecolor = toRGB('black'),
          linewidth = 3,
          titlefont = f)

y1 <- list(title = "Case Fatality Ratio",
           zeroline = TRUE,
           showgrid = TRUE,
           linecolor = toRGB('black'),
           linewidth = 1.5,
           titlefont = f, 
           range = c(0, 15))

y2 <- list(title = "Deaths",
           linecolor = toRGB('black'),
           linewidth = 1.5,
           titlefont = f,
           tickfont = list(colour = "red"),
           overlaying = "y",
           side = "right",
           titlefont = f, 
           range = c(0, 60000))


p15 <- plot_ly(covid, y = ~Case_Fatality_Ratio, x = ~ Province_State, 
               type = 'scatter', 
               mode = 'lines',
               name = "Case Fatality Ratio",
               labels = ~ Province_State, values = ~ Case_Fatality_Ratio,
               textposition = 'inside',
               textinfo = 'label+percent',
               hoverinfo = 'text',
               text = ~paste(Case_Fatality_Ratio, '%'),
               marker = list(colors = colors,
                             line = list(color = '#000000', width = 2)),
               showlegend = TRUE)

p15 <- p15 %>%
  add_trace(y = ~ Deaths, 
            type = 'scatter',
            mode = 'lines+markers',
            name = 'Death', 
            labels = ~ Province_State, values = ~ Deaths,
            textposition = 'inside',
            hoverinfo = 'text',
            text = ~paste(Deaths),
            yaxis = "y2")

p15 <- p15 %>%
  layout(xaxis = x, yaxis = y1, yaxis2 = y2,
         title = "COVID19 in US 01-01-2021")

ggplotly(p15) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 16:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

p16 <- covid %>%
  mutate(Province = fct_reorder(Province_State, Deaths)) %>%
  ggplot( aes(x = Province, y = Deaths) ) +
  geom_segment( aes(x = Province ,xend = Province,
                    y = 0, yend = Deaths), color="grey") +
  geom_point(size=3, color="#69b3a2") +
  coord_flip() +
  theme_ipsum() +
  theme(
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_blank(),
    legend.position="none",
    plot.title = element_text(hjust = 0.5, size = 18),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5)) +
  labs(title = "COVID19 deaths in US")

ggplotly(p16) %>%
  rangeslider() %>%
  layout(hovermode = "x")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 17:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

p17 <- df5 %>%
  ggplot(aes(x = Deaths, y = Confirmed, fill = Province_State, size = Confirmed)) +
  geom_point(color="#69b3a2", alpha=0.8, show.legend = FALSE) +
  theme_ipsum() +
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 16, hjust = 0.5),
        panel.border = element_rect(colour = '#990000', fill = NA, size = 1.5))+
  labs(title = "COVID 19 in US 29-01-2021")

ggplotly(p17, dynamicTicks = TRUE) 

# add marginal histograms
ggExtra::ggMarginal(p17, type = "histogram", color="grey")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 18:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("C://Users//PC//Desktop//total")


my_file <- list.files(pattern = "*.csv")
total = ldply(my_file, read_csv)


Bel <- filter(total, total$Country_Region == "Belgium")
Bel <- subset(Bel, select = -c(FIPS, Admin2))
Bel <- na.omit(Bel)

p18 <- Bel%>%
  plot_ly(
    x = ~ Province_State,
    y = ~ Confirmed,
    split = ~Province_State,
    type = 'violin',
    box = list(
      visible = T
    ),
    meanline = list(
      visible = TRUE
    )
  ) 

x <- list(title = "Province",
           zeroline = TRUE,
           showgrid = TRUE,
           linecolor = toRGB('black'),
           linewidth = 1.5,
           titlefont = f)

y <- list(title = "Confirmed",
          zeroline = TRUE,
          showgrid = TRUE,
          linecolor = toRGB('black'),
          linewidth = 1.5,
          titlefont = f)

p18 <- p18 %>%
  layout(
    title = "COVID19 in Belgium (01-01-2021 -> 03-07-2021)"
    ,xaxis = x,
    yaxis = y)

ggplotly(p18)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 19:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


library(treemap)

# Plot
p19 <- treemap(covid,
             
             # data
             index="Province_State",
             vSize="Deaths",
             type="index",
             
             # Main
             title="COVID deaths in US 01-01-2021",
             palette="Dark2",
             
             # Borders:
             border.col=c("black"),             
             border.lwds=1,                         
             
             # Labels
             fontsize.labels=0.5,
             fontcolor.labels="white",
             fontface.labels=1,            
             bg.labels=c("transparent"),              
             align.labels=c("left", "top"),                                  
             overlap.labels=0.5,
             inflate.labels=T)


ggplotly(p19)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' 
#' Plot 20:
#' 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vietnam1 <- Vietnam[,c(4, 5, 8)]

increase = c(0)
length(Vietnam1["Confirmed"])
for (i in 1:59) {
  increase <- c(increase, (x[i,] - x[i-1,]))
}

Vietnam1 <- cbind(Vietnam1, increase)
Vietnam2 <- Vietnam1[1:14,]


p20 <- plot_ly(Vietnam2, x = ~Last_Update, y = ~ increase, 
               type = "waterfall", base = 1474, 
               decreasing = list(marker = list(color = "Maroon", line = list(color = "red", width = 2))),
               increasing = (marker = list(color = "Teal")),
               totals = list(marker = list(color = "deep sky blue", line = list(color = 'blue', width = 3))))
p20 <- p20 %>%
  layout(title = "COVID19 in Viet Nam (2 weeks)", xaxis = list(title = "", tickfont = "16", ticks = "outside"),
         yaxis = list(title = ""), waterfallgap = "0.3")


p20
