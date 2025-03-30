library(devtools)
library(nbastatR)
library(dplyr)
library(ggplot2)
library(purrr)
library(gganimate)
devtools::install_github("abresler/nbastatR")
devtools::install_github("abresler/nbastatR", force = TRUE)

shots2019 <- teams_shots(teams = "Milwaukee Bucks", team_ids = NULL,
                         all_active_teams = F, season_types = "Regular Season", seasons = 2019,
                         measures = "FGA", periods = 0, months = 0, date_from = NA,
                         date_to = NA, nest_data = F, return_message = T)

shots2019 <- shots2019 %>%
  mutate(points = case_when(
    distanceShot < 23.75 ~ 2,
    distanceShot >= 23.75 & distanceShot< 29 ~ 3,
    distanceShot >= 29 ~ 4
    )
  )

expectedValue <- shots2019 %>%
  ungroup() %>%
  group_by(points) %>%
  summarize(
    attempts = n(),
    makes = sum(isShotMade == TRUE),
    shootingPercentage = makes / attempts,
    EV = shootingPercentage * first(points),
    .groups = "drop"
  )

expectedValue
