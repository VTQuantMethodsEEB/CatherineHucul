# clear workspace
rm(list=ls()) 

#reading in the csv file
predBehav = read.csv("pred_behav.csv") 

#load the libraries needed
library(ggplot2)
library(gridExtra)
library(viridis)
library(tidyverse)
library(tidyr)
library(dplyr)

#reminding myself what the titles of each of my columns are
names(predBehav)

#make all location tags uppercase
predBehav$Location=as.factor(toupper(predBehav$Location))

#group data by Location + take mean of male low chips

predBehav %>%
  group_by(Location)%>%
  summarise(male.low.chips=mean(M.low.chip,na.rm=TRUE))

  ######### Is there a way to put the mutate at the end of the line 23 group by/summarise thing?
  ######### Because it throws an error if I just transplant line 33 to line 26
#add the mean of the M.low.chip to predBehav
predBehav = predBehav %>% 
  group_by(Location) %>% 
  #add column where each row has the mean of the low chips from the males per Location. Not really useful, but interesting to figure out.
  mutate(M.low.chip.mean=mean(M.low.chip)) %>%
  mutate(F.high.chip.mean=mean(F.high.chip))
predBehav = predBehav %>%
  group_by(Habitat) %>%
  mutate(mLowChipMeanHabitat=mean(M.low.chip))

#make sure predBehav got the column
View(predBehav)

#Change the names of the predator trials to raccoon or beach ball
predBehav$Behavior.Type=as.character(predBehav$Behavior.Type)
predBehav$nBehavior.Type[predBehav$Behavior.Type=="PRED A"]="Raccoon"
predBehav$nBehavior.Type[predBehav$Behavior.Type=="PRED B"]="Beach Ball"

#create graph with the x axis being either pred a or b, y = the low chip number with the color of the dots corresponding to location
g1=ggplot(data=predBehav,aes(x=nBehavior.Type,y=M.low.chip,color=Location))+
  geom_point(size=2)+
  ylab("Low Chips (Male)")+
  xlab("Object")

g1

#second graph where the xaxis has the locations and the y axis is only the mean of each chip for location
g2 = ggplot(data=predBehav,aes(x=Location, y=M.low.chip.mean,color=Location))+
  geom_point(size=2)+
  ylab("Mean Low Chips (Male)")
g2

#third graph showing the distance from the object
g4 = ggplot(data = predBehav, aes(x=nBehavior.Type, y=M.Distance, color=Location))+
  geom_point(size=2)+
  ylab("Distance from Object")+
  xlab("Object")

g4

#Tried to get the both male and female low chips on the same y axis, but could't figure out how to color them differently to clearly show what data point comes from what?
#Does that make sense?

#g3= ggplot(data=predBehav, aes(x=Habitat, y=F.low.chip,M.low.chip, color=Location))+
#  geom_col()+
#  geom_point()+
#  ylab("Low Chips")
#g3


