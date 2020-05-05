rm(list=ls()) # clears workspace

predDat <- read.csv("PredDataNew.csv")
library(MASS)
library(effects)
library(ggplot2)
library(dplyr)
library(lme4)

shapiro.test(predDat$DistanceScore)
#Data are normal? Didn't expect that.
shapiro.test(predDat$M.high.chip)
#Data not normal
hist(predDat$M.high.chip) #data is strongly left skewed... Spit, which means the rest of the glms I ran before now aren't good?
head(predDat)

#####Are alarm calls (high chips) dictated by type of habitat and type of predator (ball or raccoon)
mHighChip<-glm(M.high.chip~Habitat*predscore,na.action=na.omit, data=predDat, family = "poisson")
summary(mHighChip)

plot(allEffects(mHighChip))
#Urban habitats have significantly higher amounts of alarm calls than the rural habitats (p= 0.00312)
#Raccoon caused more alarm calls than the ball (p< 2e-16 )
#urban and raccoon had the highest number of alarm calls.


#does the distance a bird is willing to get to a real or fake predator depend on the habitat it is in?
racVball <- glm(DistanceScore~predscore*Habitat, data =predDat, family="poisson")
summary(racVball)
#Nothing is significantly different, all p values are >0.7. 
#The distance a bird is from the mount is not significantly dictated by the mount or habitat.

l1 <-glm(DistanceScore~Habitat*predscore,na.action=na.omit,data=predDat, family="poisson")
l2 <-glm(DistanceScore~Habitat+predscore,na.action=na.omit,data=predDat, family="poisson")
l3 <- glm(DistanceScore~1,data = predDat, family="poisson") 

AIC(l3, l2, l1)

#Null model is the best model. There truly is no interaction between habitat or mount type on the distance the bird is from the mount.


racVball <- glmer(DistanceScore~Habitat +(1|Location), data = predDat, family="poisson")
summary(racVball)

#I know this is giving an error - I don't think I have enough variance across locations to run
# Addding the random effect of Location 
