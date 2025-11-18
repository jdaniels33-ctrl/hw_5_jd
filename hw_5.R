library(tidyverse)
library(tigris)

#load dataset and filter Baltimore homicides
balt_homicides <- homicides %>% 
  filter(city == "Baltimore")

#make a new column for city and state together
balt_homicides <- balt_homicides %>% 
  mutate(location = paste(city, state, sep = ", "))

#change reported_date to date format with lubridate
balt_homicides$reported_date <- ymd(balt_homicides$reported_date)
