#devtools::install_github('robert-frey/collegebaseball', force = T)
rm(list = ls())
library(collegebaseball)
library(gt)
library(gtExtras)
library(tidyverse)
source('logo.R')

collegebaseball::ncaa_school_id_lookup('Louisiana',2025)

df1 <- collegebaseball::ncaa_teams(years = 2025) %>%
  filter(conference == 'Sun Belt')

df1$team_id = str_replace(df1$team_id,"App St.","Appalachian State")
df1$team_id = str_replace(df1$team_id,"ULM","Louisiana Monroe")
df1$team_id = str_replace(df1$team_id,"Georgia St.","Georgia State")


D1list <- list()
for (i in 1:nrow(df1)) {
  D1list[[i]] = collegebaseball::ncaa_stats(df1$team_id[i], year = 2025, type = 'batting')
}


D1IDs = plyr::ldply(D1list,data.frame) %>%
  janitor::clean_names()

sbc <- D1IDs %>%
  filter(ab >1)


ba <- sbc %>%
  filter(ab > 8) %>%
  arrange(desc(ba)) %>%
  head(10) %>%
  select(player_name,pos, team_name, ba) %>%
  gt() 


ba %>%
  gt_theme_espn()



ba1 <- merge(ba,logo2) %>%
  distinct(player_name, .keep_all = TRUE)%>%
  arrange(desc(ba))%>%
  select(player_name, pos,logo, team_name, ba)%>%
  gt() %>%
  gt_img_rows(columns = logo, img_source = 'web', height = 40) %>%
  tab_options(data_row.padding = px(1)) %>%
  cols_label('player_name' = 'player',
             'pos' = 'pos',
             'logo' = ' ',
             'team_name' = 'school',
             'ba','ba') %>%
  tab_header(title = "Sun Belt Week 1 Hitting Leaders",
             subtitle = 'Min. 8 ABs')
ba1 %>%
  gt_theme_espn()




#%>%
  gt() %>%
  gt_img_rows(columns = logo, img_source = 'web', height = 10) %>%
  tab_options(data_row.padding = px(1)) %>%
  cols_label('player_name' = 'player',
             'pos' = 'pos',
             'logo' = ' ',
             'team_name' = 'school',
             'ba','ba')
ba1 %>%
  gt_theme_espn()


########################################

D1list_pitcher <- list()
for (i in 1:nrow(df1)) {
  D1list_pitcher[[i]] = collegebaseball::ncaa_stats(df1$team_id[i], year = 2025, type = 'pitching')
}


D1IDs_pitch = plyr::ldply(D1list_pitcher,data.frame) %>%
  janitor::clean_names()


p1<- D1IDs_pitch %>%
  filter(gs >= 1) %>%
  arrange(desc(ip)) %>%
  head (15)


p2 <- p1 %>%
  select(player_name, team_name, era, ip) %>%
  gt()
p2


p3<- merge(p2,logo3) %>%
  distinct(player_name, .keep_all = TRUE) %>%
  arrange(desc(ip))%>%
  select(player_name,logo, team_name, ip, era)%>%
  gt() %>%
  gt_img_rows(columns = logo, img_source = 'web', height = 40) %>%
  tab_options(data_row.padding = px(1)) %>%
  cols_label('player_name' = 'player',
             'logo' = ' ',
             'team_name' = 'school',
             'ip'='ip',
             'era'= 'era') %>%
  tab_header(title = "Sun Belt Week 1 Starting Pitcher Leaders",
             subtitle = 'Min. 5 IP')
p3 %>%
  gt_theme_espn()



