
library(tidyverse)
##glm with predator data - ball & raccoon

predDat <- read.csv("PredDataNew.csv")
head(predDat)

rac.urban.dat = predDat %>%
  filter(predscore=="rac")%>%
  filter(Habitat=="Urban")

racVball <- glm(DistanceScore~M.high.chip, data = rac.urban.dat, family="poisson")
summary(racVball)
#1.2889/7

#ordinal regression#
library(MASS)
model= polr(as.factor(DistanceScore) ~ predscore , data = predDat, Hess = TRUE)
summary(model)
#https://www.r-bloggers.com/how-to-perform-ordinal-logistic-regression-in-r/

#does the distance a bird is willing to get to a real or fake predator depend on the habitat it is in?
racVball <- glm(DistanceScore~predscore*Habitat, data =predDat, family="poisson")
summary(racVball)
#distance score is how close the bird is to the raccoon or ball

##number of alarm calls - how does that depend on type of predator and the habitat?
racVball <- glm(DistanceScore~predscore*Habitat, data =predDat, family="poisson")
summary(racVball)


library(lme4)
racVball <- glmer(DistanceScore~Habitat +(1|Location), data = predDat, family="poisson")
summary(racVball)
#I know this is giving an error - I don't think I have enough variance across locations to run
