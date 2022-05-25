
library("ggplot2")
library("maps")
library("mapproj")
library("patchwork")
source("summary.R")


AL_Comp <- proj %>% 
  group_by(year) %>% 
  filter(year == 2015 | year == 2018) %>% 
  filter(state == "AL") %>% 
  summarize(black_AL = sum(black_jail_pop_rate, na.rm = TRUE), white_AL = sum(white_jail_pop_rate, na.rm = TRUE))


Comparsion <- ggplot(data = AL_Comp) +
  geom_col(mapping = aes(x = year, y=black_AL, color = "black In Jail")) +
  geom_col(mapping = aes(x = year, y=white_AL, color = "white in Jail")) +
  labs(x= "year", y = "Amount of people in jail") +
  ggtitle("Black & White incarseration numbers from 2015-2018")