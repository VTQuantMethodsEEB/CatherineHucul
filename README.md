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

examined data for mistakes, put data in tidy format (I think) mutate + summarise the data. Week 3 included a few ggplots using the data. g1 was kind of worked out through your code - it showed the male low chips on the y axis and the types of objects the birds were exposed to. I'm interested to see if there's a difference in response between the beach ball and the raccoon -low chips and average distance from the object are both things that show boldness from the song sparrows. I tried to get both male and female low chips on the same graph, but couldn't figure out how to change the colors based on the sex.I tried to pivot the table, however I ust can't wrap my head around the idea of pivot.