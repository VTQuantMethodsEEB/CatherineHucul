rm(list=ls()) # clears workspace


#load in the new dataset (same data set as before, but with some additional data for analysis done outside of class)
predDat <- read.csv("PredDataNew.csv")
head(predDat)

#run the linear model of high chip by distance score using predDat data
#DistanceScore = binomial data based on how far the bird is from the mount. 1=0 to 6 ft, 2=7 to 11 feet etc up to 4= >24 always
racVball <- lm(DistanceScore~M.high.chip, data = predDat, subset=predscore=="rac" & Habitat=="Urban")
#rac.dat.only  = predDat %>%
#  filter(predscore=="rac")


#Test for liniearity
par(mfrow=c(2,2))  # set 2 rows and 2 column plot layout
plot(racVball)
#Unsurprisingly, Normal Q-Q doesn't quite fit, and residuals are all sorts of messed up.


##assess and anaylyze the commentary in the code
racxdist=ggplot(data=predDat, aes(x=DistanceScore, y=M.high.chip))+ 
  geom_point()+
  stat_smooth(method = "lm")+
  theme_bw() + 
  theme(axis.title=element_text(size=20),axis.text=element_text(size=10),panel.grid = element_blank(), axis.line=element_line(),legend.position="top",legend.title=element_blank())
plot(racxdist)

#There's a negative trend between distance and number of chips? As the distance decreased, the number of chips went higher?


#############Week 8 Assignment###################
## Are the number of high and low chips based on distance?
hiVlow <- lm(DistanceScore~M.high.chip+M.low.chip, data = predDat, subset=predscore == "rac" &Habitat == "Urban")
summary(hiVlow)

View(predDat)


#pp <- with(data=predDat,expand.grid(time=levels(M.high.chip),light=levels(M.low.chip)))
#pp$DistanceScore <- predict(hiVlow,newdata=pp)

#ggplot(pp,aes(x=time,y=grahami,colour=light))+
#  geom_point()+
#  geom_line(aes(group=light))

#Are the number of low chips based on the number of high chips and the distance?
hiVlow <- lm(DistanceScore~M.high.chip*M.low.chip, data = predDat, subset=predscore == "rac" &Habitat == "Urban")
summary(hiVlow)

#####I just couldn't figure out the graphs. I could get everything else running,
##### but the graphs kept throwing an "Error in eval(predvars, data, env) : object 'M.high.chip' not found"
##### I don't know why M.high.chip was able to be found by everything BUT my graphs.
