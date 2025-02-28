sbcschools <- c("Appalachian State",'Louisiana','Southern Mississippi', 'Troy', 'James Madison', 'Georgia Southern','Coastal Carolina','Old Dominion','South Alabama','Texas State','Georgia State',
                'Louisiana Monroe','Marshall','Arkansas State')

team_name <- c( "App State"  ,  "Coastal Carolina"   ,  "Georgia St."     ,   "ULM"   ,  "Marshall"   ,          "Old Dominion"     ,    "South Alabama"     ,  
               "Southern Miss.", "Troy"           ,      "Troy" )


logo <- readr::read_csv('logos.csv') %>%
  filter(school %in% sbcschools) 

ba_team <-c("Appalachian State",'Louisiana Monroe','Coastal Carolina','Troy','Southern Mississippi','Marshall','South Alabama','Georgia State','Old Dominion','Troy')
pitch_team <- c("Coastal Carolina", "Southern Miss.",   "Southern Mississippi"  , "Texas State"   ,     "Troy"     ,        "Georgia Southern"   ,  "Georgia State" ,     "South Alabama"   ,
                "Arkansas St.", "Georgia St."    ,  "Louisiana"     ,   "Marshall"      ,   "Marshall"    ,     "Old Dominion"  ,   "Old Dominion"  )

logo2 <- logo %>%
  filter(school %in% ba_team) %>%
  add_row(school = 'Troy', logo = 'http://a.espncdn.com/i/teamlogos/ncaa/500/2653.png')  %>%
  mutate(team_name = team_name)



pitch_names <- c("Coastal Carolina"   ,  "Ga. Southern" ,    "Georgia St."     ,   "Louisiana"      ,      "Marshall"    ,         "Old Dominion"     ,    "South Alabama"  ,     
                 "Southern Miss.", "Texas St."        ,  "Troy"        ,         "Southern Miss." ,"Old Dominion"   ,      "Marshall"       ,      "Georgia St.",
                  "Arkansas St.")

logo3 <- logo %>%
  filter(school %in% pitch_team) %>%
  add_row(school = 'Southern Mississippi', logo = 'http://a.espncdn.com/i/teamlogos/ncaa/500/2572.png') %>%
  add_row(school = 'Old Dominion', logo = 'http://a.espncdn.com/i/teamlogos/ncaa/500/295.png') %>%
  add_row(school = 'Marshall', logo = 'http://a.espncdn.com/i/teamlogos/ncaa/500/276.png') %>%
  add_row(school = 'Georgia State', logo = 'http://a.espncdn.com/i/teamlogos/ncaa/500/2247.png') %>%
  add_row(school = 'Arkansas State', logo = 'http://a.espncdn.com/i/teamlogos/ncaa/500/2032.png') %>%
  mutate(team_name = pitch_names)

