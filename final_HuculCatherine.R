rm(list=ls()) # clears workspace

predDat <- read.csv("PredDataNew.csv")
library(MASS)
library(effects)
library(ggplot2)
library(dplyr)
library(lme4)

head(predDat)

#Male data tests
shapiro.test(predDat$DistanceScore)
#Male distance score are not normal, p = 9.609e-06
#Transformations tried pushed data to the right too much
#However the histogram looks normal enough?
shapiro.test(predDat$M.high.chip)
#Male alarm call numbers are not normal, p =1.238e-09

#Female
shapiro.test(predDat$FDistanceScore)
#FeMale distance score are not normal, p = 9.313e-07 + heavily left skewed. 
#normal transformations didn't fix data - unsure how to get it back to normal.
shapiro.test(predDat$F.high.chip)
#Female alarm call numbers are not normal, p-value = 1.237e-08



#####does the number of alarm calls produced depend on the habitat + on the type of model
#Male alarm calls
mHighChip<-glm(M.high.chip~Habitat*predscore,na.action=na.omit, data=predDat)
summary(mHighChip)
# Habitat does not have an effect on the male alarm calls. (p = 0.908)
# Raccoon or ball doesn't matter (p=0.221)

#Female alarm calls
fHighChip <- glm (F.high.chip~Habitat*predscore, na.action=na.omit, data=predDat)
summary(fHighChip)
# Female urban birds alarm call more than the rural birds (p = .00134). allEffects show it's the ball that's pulling the chips up
#However, it doesn't matter if there;s a raccoon or beach ball.
#interaction between Habitat + predator mount is singifciant (p = .00963)
plot(allEffects(fHighChip))

#does the distance a bird is willing to get to a real or fake predator depend on the habitat it is in?
####Male distance
racVball <- glm(DistanceScore~predscore*Habitat, data = predDat, family="poisson")
summary(racVball)

plot(allEffects(racVball))


####Female distance
FracVball <- glm(FDistanceScore~predscore*Habitat, data =predDat, family="poisson")
summary(FracVball)

#Nothing is significantly different, all male p values are  = 0.221. Female p values = 0.284
#The distance a bird is from the mount is not significantly dictated by the mount or habitat.

#Create a subset of just the urban and just the rural sites
rac.urban.dat = predDat %>%
  filter(Habitat=="Urban")
rac.rural.dat = predDat %>%
  filter(Habitat=="Rural")

  

######Plot the distance scores of both female and male together, first rural
p1<-ggplot(data=rac.rural.dat,aes(x=predscore,y=DistanceScore,color=Location))+
  geom_point(size=2,shape =1)+
  geom_point(data=rac.rural.dat, aes(x=predscore, y=FDistanceScore, color=Location))+
  geom_jitter(shape=1, position=position_jitter(0.3))
p1
######Then urban
p2<-ggplot(data=rac.urban.dat,aes(x=predscore,y=DistanceScore,color=Location))+
  geom_point(size=2,shape =1)+
  geom_point(data=rac.urban.dat, aes(x=predscore, y=FDistanceScore, color=Location))+
  geom_jitter(shape=1, position=position_jitter(0.3))
p2

#####Hopefully showing what I wanted to in the paper.


#plot1<-ggplot(data=rac.urban.dat,aes(x=predscore,y=DistanceScore,color=Location))+
#  geom_point(size=2,shape =1)+
#  geom_jitter(shape=1, position=position_jitter(0.2))
#plot1


#plot4<-ggplot(data=rac.rural.dat,aes(x=predscore,y=FDistanceScore,color=Location))+
#  geom_point(size=2,shape =1)+
  #geom_point(data=rac.rural.dat, aes(x=predscore,y=FDistanceScore,col = Location))+
#  geom_jitter(shape=2, position=position_jitter(0.2))
#plot4
