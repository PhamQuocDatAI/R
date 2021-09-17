

#Ngày 25/05/2021
#7.6 PairPlot
setwd("C:/Users/ASUS/Desktop/R/BT R 25-05-2021")
Benthic <-read.table(file="RIKZ2.txt", header=TRUE)
pairs(Benthic[,2:9])


pairs(Benthic[,2:9], 
      diag.panel = panel.hist,
      upper.panel = panel.smooth,
      lower.panel = panel.cor
)
help(pairs)


example(pairs) 


pairs> pairs(USJudgeRatings, 
             lower.panel = panel.smooth, 
             upper.panel = panel.cor,
             pairs+       gap=0, 
             row1attop=FALSE)






#Hàm Coplot


coplot(Richness ~ NAP | as.factor(Beach),
       pch=19, data=Benthic)
coplot(Richness ~ NAP | grainsize,
       pch=19, data=Benthic)






panel.lm= function(x,y,...){
  tmp <- lm(y~x, na.action = na.omit)
  abline(tmp)
  points(x, y,...)
}
coplot(Richness ~ NAP | as.factor(Beach),
       pch=19, panel=panel.lm, data=Benthic)


#Richness vs NAP --> Beach
#V??? bi???u ð??? coplot s??? d???ng data set vegetation
#richness vs bi???n b???t k??? d???a trên ðk là transec

