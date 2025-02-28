#install.packages('ggimage')
library(tidyverse)
library(sf)
library(ggimage)
library(ggpubr)
library(ggiraph)
library(plotly)
sbc_geoid <- c('22055','48209','13121','22073','28035','01097','01109','05049','13031','45051','37189','51710','54011','51165')



logo_schools <- c('Arkansas State','South Alabama','Marshall','Louisiana','Appalachian State','Troy','Southern Mississippi','Texas State','Georgia Southern','Georgia State',
                  'Old Dominion','Coastal Carolina','Louisiana Monroe','James Madison')


df0 <- sf::st_read('tl_2024_us_county.shp')


df1 <- df0 %>%
  filter(GEOID %in% sbc_geoid) %>%
  mutate(school = logo_schools)

ggplot() +
  geom_sf(data = df1)


usa <- sf::st_read('tl_2024_us_state.shp')


statefips <- c('22','48','05','28','01','13','45','37','54','51')

usa1 <-usa %>%
  filter(GEOID %in% statefips)


lat <- df1$INTPTLAT
lng <- df1$INTPTLON


df2 <- data.frame(lat = lat, lng = lng) %>%
  mutate(lat = as.numeric(lat)) %>%
  mutate(lng = as.numeric(lng)) %>%
  mutate(school = logo_schools)


logo <- readr::read_csv('logos.csv') %>%
  filter(school %in% logo_schools) %>%
  select(school,logo)


logo2 <- logo[order(names(logo))]



df3 <- merge(df2,logo2)









spatial_data <- st_as_sf(df2, 
                         coords = c("lng", "lat"), crs = 4326) 












#############################

source('map_info.R')


sbc_map_info <- merge(spatial_data,main3)


ggsf <- ggplot(sbc_map_info) +
  geom_sf(data = usa1, fill = 'lightblue')+
  geom_sf(data = sbc_map_info,aes(fill = 'NA', label = info)) +
  geom_image(data = df3, aes(x = lng, y= lat, image = logo),size = .1) +
  geom_sf_interactive(aes(data_id = school,
                          tooltip = info),
                      fill = 'NA',
                      color = 'NA') +
theme_void() +
  theme(legend.position = 'none')



girafe(ggobj = ggsf,
       options = list(
         opts_selection(css = girafe_css(
           css = 'opacity:0.0;'
         )),
         opts_sizing(rescale = TRUE, width = 1),
         opts_hover(css = 'opacity:0.0;'),
         opts_hover_inv(
           css = girafe_css(
             css = 'opacity:0.0;'
           )
         )))


  
         
             