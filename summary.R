library(dplyr)
library(tidyverse)
library(stringr)
library(maps)

  jail_info<- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")
  
  number_obs <- nrow(jail_info)
  number_features <- ncol(jail_info)
  
  
  proj <- jail_info %>% select(year, county_name,state, black_jail_pop_rate, white_jail_pop_rate, fips)
  
  black_white_jail_max <- proj %>% 
    filter(black_jail_pop_rate == max(black_jail_pop_rate, na.rm = TRUE)) %>% 
    summarise(black_jail_pop_rate, white_jail_pop_rate)
  
  black_white_jail_min <- proj %>% 
    group_by(state) %>% 
    filter(black_jail_pop_rate == max(black_jail_pop_rate, na.rm = TRUE)) %>% 
    summarize(black_jail_pop_rate, white_jail_pop_rate, state)
  
  black_white_jail_total <- proj %>% 
    filter(state == "MD") %>% 
    filter(year == max(year)) %>% 
    mutate(total_black = sum(black_jail_pop_rate, na.rm = TRUE)) %>% 
    mutate(total_white = sum(white_jail_pop_rate, na.rm = TRUE)) %>% 
    select(total_black, total_white) 
  head(black_white_jail_total, 1)
  
  black_white_jail_ave <- proj %>%
    filter(state == "GA") %>% 
    filter(year == max(year)) %>% 
    mutate(total_black = sum(black_jail_pop_rate, na.rm = TRUE)) %>% 
    mutate(total_white = sum(white_jail_pop_rate, na.rm = TRUE)) %>% 
    summarize(total_black, total_white) 
  head(black_white_jail_ave, 1)
  
  black_white_jail_GA_max <- proj %>% 
    filter(state == "GA") %>% 
    filter(year == max(year)) %>% 
    filter(black_jail_pop_rate == max(black_jail_pop_rate, na.rm = TRUE)) %>% 
    summarise(black_jail_pop_rate, white_jail_pop_rate)
  