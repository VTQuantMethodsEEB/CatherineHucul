#load important packages##
library(tidyverse)
library(tidyr)
library(dplyr)

#read in behavior data
predBehav = read.csv("pred_behav.csv")

predBehav %>%
  group_by(Habitat)

?group_by
