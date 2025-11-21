library(tidyverse)
library(scales)

#load dataset and filter Baltimore homicides
balt_homicides <- read_csv("data/homicide-data.csv") %>% 
  filter(city == "Baltimore")

#make a new column for city and state together
balt_homicides <- balt_homicides %>% 
  mutate(location = paste(city, state, sep = ", "))

#change reported_date to date format with lubridate
balt_homicides$reported_date <- ymd(balt_homicides$reported_date)

#Need to indicate which months are Nov - Apr
balt_homicides <- balt_homicides %>% 
  mutate(months = month(reported_date))

balt_homicides <- balt_homicides %>% 
  mutate(cold_vs_warm = if_else(months %in% c(1:4, 11, 12), "cold", "warm"))

         

