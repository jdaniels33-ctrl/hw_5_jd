library(tidyverse)
library(tigris)

#load dataset and filter Los Angeles (love the Harry Bosch series and spinoffs)
homicides <- read_csv("data/homicide-data.csv")
la_homicides <- homicides %>% 
  filter(city == "Los Angeles")

