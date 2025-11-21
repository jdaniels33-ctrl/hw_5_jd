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

#Need a column that indicates just year and month. Already have a month column
#in line 15-17, so make a year column and then make another column with both
#and put into YYYY-MM format.

balt_homicides <- balt_homicides %>% 
  mutate(yr = year(reported_date))

balt_homicides <- balt_homicides %>% 
  mutate(yr_month = paste(yr, months, sep = "-"))

balt_homicides$yr_month <- ym(balt_homicides$yr_month)
#this last column is ugly but should work because year and month are correct
#Ignore the day!
         


