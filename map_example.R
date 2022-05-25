
library("ggplot2")
library("maps")
library("mapproj")
library("patchwork")


AL_Map <- proj %>% 
  filter(year == max(year)) 

county_shapes <- map_data("county") %>%
  unite(polyname, region, subregion, sep = ",") %>% 
  left_join(county.fips, by = "polyname")

map_data <- county_shapes %>% 
  left_join(AL_Map, by ="fips") %>% 
  filter(state == "AL")

#clean map

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank() 
  )

#create map
cases_Map <- ggplot(map_data) +
  geom_polygon(
    mapping = aes(x= long, y= lat, group = group, fill = black_jail_pop_rate),
    color="gray", size = 0.3
  ) +
  coord_map() +
  scale_fill_continuous(limits = c(0, max(map_data$black_jail_pop_rate)), na.value= "white", low = "yellow", high = "red") +
  blank_theme +
  ggtitle("Black Jail Population in Alabama")

