rm(list=ls()) # clears workspace

predDat <- read.csv("PredDataNew.csv")
##load packages##
library(ggplot2)
library(MASS)
library(reshape2)
library(tidyverse)
library(lme4)
library(dplyr)

#I know all of these are giving an error - I don't think I have enough variance across locations nor nest IDs (NID) to run properly
glmr1 <- glmer(DistanceScore~predscore +(1|NID), data = predDat, family="poisson")
summary(glmr1)

glmr1a <- glmer(DistanceScore~predscore +(1|Location), data = predDat, family="poisson")
summary(glmr1a)

glmr2 <- glmer(DistanceScore~Habitat +(1|Location)+(1|NID), data = predDat, family="poisson")
summary(glmr2)

glmr3 <- glmer(DistanceScore~predscore*Habitat +(1|Location)+(1|NID), data = predDat, family="poisson")
summary(glmr3)


AIC(glmr1, glmr1a, glmr2, glmr3)

#       df      AIC
#glmr1   3 125.6100
#glmr1a  3 125.6100
#glmr2   4 127.5065
#glmr3   6 131.4642

#####Nest ID and Location don't have enough data to run properly. Ran a few other iterations of the random effects with predscore and habitat, however felt too much like fishing for significance and not like actual analysis.
#####In any case, no matter what was added, the AIC selection still showed tht the first (1) or second (1a) model was the best fit for what I found.
predDat$glmr1 = predict(glmr1a,newdata= predDat,re.form=NA,type="response")

#####I'm unsure how to create a good predict figure with this. Is there even a good predict figure here?
