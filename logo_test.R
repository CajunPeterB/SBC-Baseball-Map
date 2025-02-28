logo_schools <- c('Arkansas State','South Alabama','Marshall','Louisiana','Appalachian State','Troy','Southern Mississippi','Texas State','Georgia Southern','Georgia State',
                  'Old Dominion','Coastal Carolina','Louisiana Monroe','James Madison')

logo <- readr::read_csv('logos.csv') %>%
  filter(school %in% logo_schools) %>%
  select(logo)




sbctest <- c('22055','48209','13121')


sbctest1 <- df0 %>%
  filter(GEOID %in% sbctest)

sbctest2 <- cbind(sbctest1,logo)



ggplot() +
  geom_sf(data = sbctest2) +
  geom_image(sbctest2, mapping = aes(x = INTPTLON, y = INTPTLAT, image = logo, size = .5))