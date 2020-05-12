rm(list=ls()) # clears workspace

predDat <- read.csv("PredDataNew.csv")
library(MASS)
library(effects)
library(ggplot2)
library(dplyr)

mHighChip<-glm(M.high.chip~Habitat*predscore,na.action=na.omit, data=predDat)
  summary(mHighChip)
#Nothing is significant - most closest to significant was the type of mount (p=0.221). Otherwise habitat had a p=0.908 and the interaction between habitat and predator type was a 0.704
  
  
plot(allEffects(mHighChip))
#Looks like the males chip more often in rural sites rather than in urban sites in response to the raccoon
#Overall, raccoons caused more chips in general, while balls responded in fewer chips. Rural birds alarm called more than urban birds in response to the raccoon, however nothing was significant.

############Tried to fix up the predict so that distance score was on the x axis and alarm call (high chip) was on the y

predDat$mHighChip = predict(mHighChip,type="response",newdata = predDat)

#Looks like predict wasn't working the way I envisioned. Data doesn't give a good line to show predictions

plot1<-ggplot(data=predDat,aes(x=DistanceScore,y=mHighChip,color=Habitat))+
  geom_line()+
  geom_jitter()+
  geom_point(data=predDat, aes(x=DistanceScore,y=M.high.chip,col = Habitat))
  #geom_bar(aes(x=DistanceScore,y=Habitat, color = predscore))
plot1


#does the distance a bird is willing to get to a real or fake predator depend on the habitat it is in?
racVball <- glm(DistanceScore~predscore*Habitat, data =predDat, family="poisson")
summary(racVball)

#Nothing is significantly different





########### Week 11 #################
l1 <-glm(DistanceScore~predscore,na.action=na.omit,data=predDat, family="poisson")
l2 <-glm(DistanceScore~Habitat+predscore,na.action=na.omit,data=predDat, family="poisson")
l3 <-glm(DistanceScore~Habitat*predscore,na.action=na.omit,data=predDat, family="poisson")
l4 <- glm(DistanceScore~1,data = predDat, family="poisson") 

anova(l4, l1, l2, l3, test = "LRT")

## Model 1: DistanceScore ~ 1
## Model 2: DistanceScore ~ predscore
## Model 3: DistanceScore ~ Habitat + predscore
## Model 4: DistanceScore ~ Habitat * predscore
## Resid. Df Resid. Dev Df Deviance Pr(>Chi)
## 1        37     6.3717                     
## 2        36     6.3372  1 0.034484   0.8527
## 3        35     6.1915  1 0.145717   0.7027
## 4        34     6.1915  1 0.000006   0.9980

anova(l4, l3)

#Model 1: DistanceScore ~ 1
#Model 2: DistanceScore ~ Habitat * predscore
#Resid. Df Resid. Dev Df Deviance
#1        37     6.3717            
#2        34     6.1915  3  0.18021

anova(l4, l2)
#Analysis of Deviance Table

#Model 1: DistanceScore ~ 1
#Model 2: DistanceScore ~ Habitat + predscore
#Resid. Df Resid. Dev Df Deviance
#1        37     6.3717            
#2        35     6.1915  2   0.1802
 
##### If i'm reading this properly, it means the additative model is the best model to have used for the rest of the analysis
##### since it's a lower p value/closer to .05 when it's  

###AIC models###
m1 <- glm(DistanceScore~predscore*Habitat, data =predDat, family="poisson")
m2 <- glm(DistanceScore~predscore+Habitat, data =predDat, family="poisson")
m3 <- glm(DistanceScore~1,data=predDat, family="poisson")



AIC(l1, l2, l3, l4)

#df      AIC
#m1  4 127.4642
#m2  3 125.4642
#m3  1 121.6444
##So my null model (m3) is the best fit model.




######Notes for future analysis#######
#can possibly use poissan and just run the identical for the y variable. use poissan using discreet real numbers
#look at residual deviance divided by something to to check if variances are very changes
#random effects - location - singular variance, note that you see it and know what it means

#think about ordinal regression - would add to the strength of the interpretation
