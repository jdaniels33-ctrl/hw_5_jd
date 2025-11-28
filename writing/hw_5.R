library(tidyverse)
library(ggthemes)
library(viridis)


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
  mutate(cold_vs_warm = if_else(months %in% c(1:4, 11, 12), "winter", "summer"))

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


# I can't generate a smooth line geom with a histogram. Need actual Y counts it
# seems.

summary_hom <- balt_homicides %>% 
  group_by(yr_month) %>% 
  summarise(count = n(),
            climate = cold_vs_warm) %>% 
  ungroup() %>% 
  unique()

# The above worked, but there is something icky about it that I had to use
# unique to get it to stop repeating the same value....I feel like the sausage
# should not be made this way.

# Lets try the figure now with a smoothing line and geom_bar instead...

hom_fig <- summary_hom %>% #The struggle to generate this figure was real
  ggplot(aes(x = yr_month, y = count, fill = climate)) +
  geom_bar(stat = "identity") +
  #The above: something I learned since having to use
  #geom bar instead of geom_histogram.
  scale_fill_manual(values = c("winter" = "cyan1", "summer" = "cornsilk")) +
  geom_vline(xintercept = ymd("2015-04-01"), colour = "red",
             linewidth = 1, linetype = 2) +
  geom_smooth(aes(fill = NULL), se = FALSE, span = 0.15,
              show.legend = FALSE) +
  labs(y = "Monthy homicides", title = "Homicides in Baltimore, MD", x = "",
       fill = "") +
  annotate("text", x = ymd("2014-08-01"), y = 40,
           label= "Arrest of\n Freddy Gray",
           size = 5, color = "cornsilk3") +
  theme_dark() +
  theme(legend.position = "bottom") #this only works if AFTER the theme_dark


  



  





  

  
  

  

