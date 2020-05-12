README
================

## Response to simulated predator presence

The data I’m planning to work with is predator behavior data collected
through last summer. Every song sparrow nest (NID) we found had a
raccoon (Pred A) and a beach ball (Pred B) presented to it. The recorded
data was collected over 6 different sites (3 rural, 3 urban) between 6am
and 9am; behaviors recorded for both male and female song sparrows and
consisted of low communication chips, high alarm chips, distance to the
ball, and latency to approach the raccoon/beach ball. Vocalizations can
range between 1 and 800 occurrences, distance is between 0 and 24
meters, and latency is still being added to the end of the dataset.

## Week 1 – Intro to R

CODE : Hucul Assignment 1 DATA: pred_behav.csv

Copied and pasted from your example: Here, I explored how to use R and did some basic calculations.

## Week 2 + 3 - Data Manipulation and GitHub

Code: week3_CatherineHucul.R
Data: pred_behav.csv

Examined data for mistakes, put data in tidy format (I think) mutate + summarise the data. Week 3 included a few ggplots using the data. g1 was kind of worked out through your code - it showed the male low chips on the y axis and the types of objects the birds were exposed to. I'm interested to see if there's a difference in response between the beach ball and the raccoon -low chips and average distance from the object are both things that show boldness from the song sparrows. I tried to get both male and female low chips on the same graph, but couldn't figure out how to change the colors based on the sex.I tried to pivot the table, however I ust can't wrap my head around the idea of pivot.

## Week 5 - Tests

Code: week5_CatherineHucul.R
Data: pred_behav.csv

1. Formulate two different hypotheses about your data, one that can be tested using a permutation test and one that can be tested using a “classical” test.

2. Write these hypotheses the in the Week 5 section of your README.

3. Implement both of these tests in R. Annotate your code so I know which hypothesis you are testing.



Hypothesis 1 (Permutation): Urban birds will low chip more on average to the predator mount (PRED A) than at the beach ball on average because it's a simulated predator presence.

Hypothesis 2 (Wilcoxon rank sum test): Rural males will stay further away from the raccoon mount (PRED A) than the beach ball (PRED B) due to it being a simulated predator presence.

##Week 8 - Linear models and parameters (After spring break!)
Code: week7+8_CatherineHucul.R
Data: PredDataNew.csv

Hypothesis: Urban birds will increase high chipping sounds the further away from the raccoon mount they are.

What does the output tell me: There's a negative trend between distance and number of chips? As the distance decreased, the number of chips went higher?


week two: Urban birds will increase their high chips + decrease the low chips the further the raccoon mount they are.

Output: Although not significant, both high and low chips decreased as the distance increased

Hyp for Interactive: The number of low chips is influenced by both the distance score and the number of high chips uttered
Output: again, not significant, but it looks like the interaction between high and low chips are positively influenced - if they're low chipping they're also high chipping?

##Week 10 + 11 - GLMS and Model Selection

Code: week10_CatherineHucul
Data: PredDataNew.csv

Hypothesis: Male high chips (alarm calls) are influenced by whether it's a ball ora raccoon, and habitat type.
Output:


Hypothesis 2: (That you helped me with) Distance is dictated by the type of mount + the habitat
Output: Nothing is significantly different - the GLM showed a p value <.7 for all intercepts (Habitat and type of "predator"). 

Results for the likelihood ratio tests and AIC model selection are found in the code (week10_CatherineHucul). Overall, the LR test said that the best fit model was the additive model of the distance by habitat and predator (glm(DistanceScore~Habitat+predscore)). However the AIC model selection says the null model is the best fit, but only by a little bit (details in the code).

##Week 12 - Mixed Models


