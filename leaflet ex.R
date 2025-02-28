library(leaflet)



lat <- sbctest1$INTPTLAT
lng <- sbctest1$INTPTLON


t <- data.frame(lat = lat, lng = lng,img = img) %>%
  mutate(lat = as.numeric(lat)) %>%
  mutate(lng = as.numeric(lng)) 

iconSet <- list(ul,txst,gast)


l1 <- leaflet() %>%
  addTiles()%>%
  addMarkers(data = t,
             icon = ~ icons(
               iconUrl = iconSet,
               iconWidth = 70,
               iconHeight = 50
             ))


ggplot() +
  geom_sf(data = usa1) +
  l1
