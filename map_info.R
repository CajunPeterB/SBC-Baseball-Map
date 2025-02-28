#devtools::install_github('robert-frey/collegebaseball', force = T)
#rm(list = ls())
library(collegebaseball)
library(gt)
library(gtExtras)
library(tidyverse)
source('logo.R')

collegebaseball::ncaa_school_id_lookup('Louisiana',2025)

df1 <- collegebaseball::ncaa_teams(years = 2025) %>%
  filter(conference == 'Sun Belt')



D1list <- list()
for (i in 1:nrow(df1)) {
  D1list[[i]] = collegebaseball::ncaa_stats(df1$team_id[i], year = 2025, type = 'batting')
}


D1IDs = plyr::ldply(D1list,data.frame) %>%
  janitor::clean_names()

sbc <- D1IDs %>%
  filter(ab >1)

sbc_batting <- sbc %>%
  group_by(team_name) %>%
  mutate(ba = mean(ba)) %>%
  select(team_name, ba) %>%
  ungroup()


sbc_batting2 <- sbc_batting %>%
  distinct(team_name,ba)

#############################################
#SELECT ERA AVGS


D1list_pitcher <- list()
for (i in 1:nrow(df1)) {
  D1list_pitcher[[i]] = collegebaseball::ncaa_stats(df1$team_id[i], year = 2025, type = 'pitching')
}


D1IDs_pitch = plyr::ldply(D1list_pitcher,data.frame) %>%
  janitor::clean_names()


p1<- D1IDs_pitch %>%
  filter(ip >1)

sbc_pitching <- p1 %>%
  group_by(team_name) %>%
  mutate(era = mean(era))%>%
  select(team_name, era)

sbc_pitching2 <- sbc_pitching %>%
  distinct(team_name,era)


##########################################
#SELECT BA LEADER PER SCHOOL ATLEAST 20 ABS



ba_lead <- sbc %>%
  group_by(team_name) %>%
  filter(ab > 21) %>%
  filter(ba == max(ba))  %>%
  select(team_name,player_name,ba)%>%
  rename('Batting Average Leader' = 'player_name') %>%
  rename('BA Individual' = 'ba')


#################
#SELECT ERA LEADER PER SCHOOL

era_lead <- p1 %>%
  group_by(team_name) %>%
  filter(ip > 6) %>%
  filter(era == min(era)) %>%
  select(team_name,player_name, era) %>%
  rename('ERA Leader' = 'player_name') %>%
  rename('ERA Individual' = 'era')%>%
  head(14)
###########################

main <- cbind(sbc_batting2,ba_lead,sbc_pitching2,era_lead) %>%
  janitor::clean_names()


main2 <- main %>%
  select(team_name, ba, batting_average_leader, ba_individual, era, era_leader, era_individual) %>%
  mutate(ba = round(ba,digits = 3)) %>%
  mutate(era = round(era,digits = 2))


main2$team_name = str_replace(main2$team_name,"App State","Appalachian State")
main2$team_name = str_replace(main2$team_name,"ULM","Louisiana Monroe")
main2$team_name = str_replace(main2$team_name,"Georgia St.","Georgia State")
main2$team_name = str_replace(main2$team_name,"Arkansas St.","Arkansas State")
main2$team_name = str_replace(main2$team_name,"Ga. Southern","Georgia Southern")
main2$team_name = str_replace(main2$team_name,"Southern Miss.","Southern Mississippi")
main2$team_name = str_replace(main2$team_name,"Texas St.","Texas State")


info <- paste0(
  '\nSchool: ', main2$team_name,
  '\nTeam BA: ',main2$ba , 
  '\nBA Leader: ', main2$batting_average_leader, " ", main2$ba_individual,
  '\nTeam ERA: ', main2$era,
  '\nERA Leader: ', main2$era_leader, " ", main2$era_individual
)






main2$info <- info

main2 <- main2 %>%
  rename('school' = 'team_name')

main3 <- main2 %>% select(school,info)


