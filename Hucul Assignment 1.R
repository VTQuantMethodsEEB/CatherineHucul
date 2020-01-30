predBehavior = read.csv("pred_behav.csv") #reading in the csv file
names(predBehavior) #show the titles of the columns

summary(predBehavior)

head(predBehavior)

#select all sites that are rural, then selecting the female distance column, column 14, row 3
predBehavior[predBehavior$Habitat=="Rural",]
predBehavior [, "F.Distance"] 
predBehavior [, 14]
predBehavior [3 ,]

## see the rural sites in easy to read worksheet?
View(predBehavior[predBehavior$Habitat=="Rural",]) 


#make all location tags uppercase
predBehavior$Location=as.factor(toupper(predBehavior$Location)) 
#add column for female low chips+high chips
predBehavior$f.vocalizations <- predBehavior$F.low.chip + predBehavior$F.high.chip

#aggregate the distance between speaker and raccoon using mean function
low.behavior <- aggregate(M.low.chip~Behavior.Type,FUN=mean,data=predBehavior)

tab1 <- table(predBehavior$M.low.chip,predBehavior$M.high.chip)


summary(predBehavior)
head(low.behavior)

     