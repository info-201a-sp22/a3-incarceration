
library("ggplot2")
library("maps")
library("mapproj")
library("patchwork")
source("summary.R")

line_chart <-  proj %>% 
  group_by(year) %>% 
  summarize(black_all = sum(black_jail_pop_rate, na.rm = TRUE), white_all = sum(white_jail_pop_rate, na.rm = TRUE))



over_Time <- ggplot(data = line_chart) +
  geom_line(mapping = aes(x = year, y= black_all, color = "red")) +
  geom_line(mapping = aes(x = year, y= white_all, color = "blue")) +
  scale_color_manual(name = "race",
                     values = c("red", "blue"),
                     labels = c("black", "white")) +
  labs(x= "year", y= "Amount of people in Jail") +                 
  ggtitle("Time Comparison Chart between White & Black")