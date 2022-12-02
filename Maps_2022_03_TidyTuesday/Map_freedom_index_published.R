#Freedom in the World ----
#The data this week comes from Freedom House and the United Nations by way of Arthur Cheib.
# Get the Data----

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

#tuesdata <- tidytuesdayR::tt_load('2022-02-22')
#tuesdata <- tidytuesdayR::tt_load(2022, week = 8)

#freedom <- tuesdata$freedom

# Or read in the data manually

freedom <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-22/freedom.csv')

#Load packages ----
library(dplyr)
library(ggplot2)
library(patchwork)
library(fuzzyjoin)
library(ggthemes)
library(tidyverse)

# Clean the names
freedom<- freedom %>%
  janitor::clean_names() %>%
  rename(civil_liberties = cl,
         political_rights = pr) %>%
  mutate(country_code = countrycode::countrycode(country, "country.name", "iso2c"))


#Making maps for Civil liberties and Political Rights----
#in the same map using map package

## pivot data ----
freedom_gathered2 <- freedom %>%
  gather(metric, value, civil_liberties, political_rights) %>%
  mutate(metric = str_to_title(str_replace_all(metric, "_", " ")),
         region_name = fct_reorder(region_name, value))


## create a map for Civil liberties ----
freedom_2020_2_CL <- freedom_gathered2 %>%
  filter(year == 2020, metric == "Civil Liberties")

world_map_freedom_2020_2_CL <- map_data("world") %>%
  as_tibble() %>%
  regex_left_join(maps::iso3166, c(region = "mapname")) %>%
  left_join(freedom_2020_2_CL, by = c(a2 = "country_code")) %>%
  filter(region != "Antarctica")


world_map_freedom_2020_2_CL %>%
  ggplot(aes(long, lat, group = group)) +
  geom_polygon(aes(fill = value)) +
  coord_map(xlim = c(-180, 180)) +
  scale_fill_gradient2(low = "dark green",
                       high = "red",
                       midpoint = 3.5,
                       guide = guide_legend(reverse = TRUE)) +
  ggthemes::theme_map() +
  labs(fill = "Civil Liberties Rating",
       title = "World Freedom Index: Civil Liberties",
       subtitle = "In 2020")

p1 <- world_map_freedom_2020_2_CL %>%
  ggplot(aes(long, lat, group = group)) +
  geom_polygon(aes(fill = value)) +
  coord_map(xlim = c(-180, 180)) +
  scale_fill_gradient2(low = "dark green",
                       high = "red",
                       midpoint = 3.5,
                       guide = guide_legend(reverse = TRUE)) +
  ggthemes::theme_map() +
  labs(fill = "Rating",
       title = "Civil Liberties")

## create a map for Political Rights ----
freedom_2020_2_PR <- freedom_gathered2 %>%
  filter(year == 2020, metric == "Political Rights")

world_map_freedom_2020_2_PR <- map_data("world") %>%
  as_tibble() %>%
  regex_left_join(maps::iso3166, c(region = "mapname")) %>%
  left_join(freedom_2020_2_PR, by = c(a2 = "country_code")) %>%
  filter(region != "Antarctica")


world_map_freedom_2020_2_PR %>%
  ggplot(aes(long, lat, group = group)) +
  geom_polygon(aes(fill = value)) +
  coord_map(xlim = c(-180, 180)) +
  scale_fill_gradient2(low = "dark green",
                       high = "red",
                       midpoint = 3.5,
                       guide = guide_legend(reverse = TRUE)) +
  ggthemes::theme_map() +
  labs(fill = "Political Rights Rating",
       title = "World Freedom Index: Political Rights",
       subtitle = "In 2020")

p2 <- world_map_freedom_2020_2_PR %>%
  ggplot(aes(long, lat, group = group)) +
  geom_polygon(aes(fill = value)) +
  coord_map(xlim = c(-180, 180)) +
  scale_fill_gradient2(low = "dark green",
                       high = "red",
                       midpoint = 3.5,
                       guide = guide_legend(reverse = TRUE)) +
  ggthemes::theme_map() +
  labs(fill = "Rating",
       title = "Political Rights"
  )



# Put final plot together and save ----


(p1/p2 + plot_annotation(title = 'Comparing World Freedom Indexes in 2020',
                         subtitle = "Green - better, Red - worse",
                         caption = "Created by Olena Thomson | Data from Freedom House | #TidyTuesday")
  + plot_layout(guides = 'collect'))

#better to safe this map manually with the size 841*700
ggsave("map_CL_PL.png")