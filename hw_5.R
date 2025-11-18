library(tidyverse)
library(tigris)

#load dataset and filter Baltimore homicides
balt_homicides <- homicides %>% 
  filter(city == "Baltimore")

