#Data Collection and Tidying
install.packages("devtools")
library(devtools)
library(nbastatR)
library(dplyr)
library(ggplot2)
devtools::install_github("abresler/nbastatR")
devtools::install_github("abresler/nbastatR", force = TRUE)

teams <- nba_teams()
ls("package:nbastatR")


shots2019 <- teams_shots(teams = "Milwaukee Bucks", team_ids = NULL,
                     all_active_teams = F, season_types = "Regular Season", seasons = 2019,
                     measures = "FGA", periods = 0, months = 0, date_from = NA,
                     date_to = NA, nest_data = F, return_message = T)

bucks_green <- "#00471B"
bucks_cream <- "#EEE1C6"
halfCourtShots <- filter(shots2019, shots2019$locationY < 400)
##Half Court Shot Chart

ggplot() +
  # Draw the court first
  draw_half_court(line_color = "black", court_background = "white") +
  # Plot shots
  geom_point(
    data = halfCourtShots,
    aes(x = locationX, y = locationY, color = isShotMade),
    alpha = 0.1,
    size = 2
  ) +
  coord_fixed() +  # keep aspect ratio consistent
  scale_color_manual(
    values = c("FALSE" = "red", "TRUE" = bucks_green),
    name = "Shot Result"
  ) +
  labs(
    title = "Milwaukee Bucks Shot Locations (2019 Season)",
    subtitle = "Colored by shot outcome",
    x = NULL,
    y = NULL
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

##Full Court Shot Chart

ggplot() +
  # Draw the court first
  draw_court(line_color = "black", court_background = "white") +
  # Plot shots
  geom_point(
    data = shots2019,
    aes(x = locationX, y = locationY, color = isShotMade),
    alpha = 0.1,
    size = 2
  ) +
  coord_fixed() +  # keep aspect ratio consistent
  scale_color_manual(
    values = c("FALSE" = "red", "TRUE" = bucks_green),
    name = "Shot Result"
  ) +
  labs(
    title = "Milwaukee Bucks Shot Locations (2019 Season)",
    subtitle = "Colored by shot outcome",
    x = NULL,
    y = NULL
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

ggplot() +
  draw_half_court()


