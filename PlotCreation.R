#Data Collection and Tidying

library(devtools)
library(nbastatR)
library(dplyr)
library(ggplot2)
library(purrr)
devtools::install_github("abresler/nbastatR")
devtools::install_github("abresler/nbastatR", force = TRUE)

Sys.setenv("VROOM_CONNECTION_SIZE" = 500000)

teams <- nba_teams()
ls("package:nbastatR")


shots2019 <- teams_shots(teams = "Milwaukee Bucks", team_ids = NULL,
                     all_active_teams = F, season_types = "Regular Season", seasons = 2019,
                     measures = "FGA", periods = 0, months = 0, date_from = NA,
                     date_to = NA, nest_data = F, return_message = T)

seasons <- 2015:2019
allSeasonsBucks <- map_dfr(seasons, ~teams_shots(teams = "Milwaukee Bucks", team_ids = NULL,
                                                 all_active_teams = F, season_types = "Regular Season", seasons = .x,
                                                 measures = "FGA", periods = 0, months = 0, date_from = NA,
                                                 date_to = NA, nest_data = F, return_message = T) %>%
  mutate(season = .x)
)

SingleSeasonPlot(shots2019, "Full")



