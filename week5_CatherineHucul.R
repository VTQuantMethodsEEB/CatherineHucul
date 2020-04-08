# clear workspace
rm(list=ls()) 

#reading in the csv file
predBehav = read.csv("pred_behav.csv")
#Hypothesis 1: male urban bird low chips between pred A and pred B


set.seed(101)
lowResult <- NA


head(predBehav)
upreda <- predBehav$M.low.chip[predBehav$Behavior.Type=="PRED A"]

upredb <- predBehav$M.low.chip[predBehav$Behavior.Type=="PRED B"]
mean(upreda) - mean(upredb)



predTrial <- data.frame(
  place=rep(c("upreda", "upredb"),
            c(length(upreda), length(upredb))),
  colonies=c(upreda,upredb)
)



for (i in 1:10000) {
  place <- sample(c(upreda,upredb)) 
  forestboot <- place[1:length(upreda)] #this says assign the first four colonies to forest
  fieldboot <- place[(length(upredb)+1):length(place)] #assign the rest of the colonies to field
  ## compute & store difference in means
  lowResult[i] <- mean(fieldboot)-mean(forestboot) #calculate the difference in the field means and the forest means
  #[i] says "where i", and i is a counter, after running this loop, i should be 1000
}
obs <- mean(upreda)-mean(upredb)

hist(lowResult,col="gray",las=1,main="")
abline(v=obs,col="red")


lowResult[lowResult>=obs]
length(lowResult[lowResult>=obs])
7711/10000
mean(lowResult>=obs)  

##what does this tell you???

## End the permutation, begin on Hyp 2 - rural male distance with Wilcoxon rank sum test


rpreda <- predBehav$M.Distance[predBehav$Behavior.Type=="PRED A"]
rpredb <- predBehav$M.Distance[predBehav$Behavior.Type=="PRED B"]

mDistance <- data.frame(
  trmt=rep(c("rpreda","rpredb"),
           c(length(rpreda), length(rpredb))),
  distances=c(rpreda,rpredb)
)

ww2<-wilcox.test(rpreda,rpredb)
ww2



####Wilcoxon rank sum test with continuity correction

#### data:  rpreda and rpredb
#### W = 89.5, p-value = 0.9606
#### alternative hypothesis: true location shift is not equal to 0
