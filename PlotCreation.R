#Data Collection and Tidying
install.packages("devtools")
library(devtools)
library(nbastatR)
devtools::install_github("abresler/nbastatR")
devtools::install_github("abresler/nbastatR", force = TRUE)
Sys.setenv("VROOM_CONNECTION_SIZE" = 524288)
teams <- nba_teams()
ls("package:nbastatR")


shots2019 <- teams_shots(teams = "Milwaukee Bucks", team_ids = NULL,
                     all_active_teams = F, season_types = "Regular Season", seasons = 2019,
                     measures = "FGA", periods = 0, months = 0, date_from = NA,
                     date_to = NA, nest_data = F, return_message = T)

library(ggplot2)


ggplot(shots2018, aes(x = locationX, y = locationY)) +
  geom_point(aes(color = isShotMade), alpha = 0.7) +
  coord_fixed() +  # Ensures x and y use the same scale
  theme_minimal() +
  labs(title = "Basic Shot Chart",
       x = "Court X",
       y = "Court Y")



# Example "Milwaukee Bucks" color scheme:
# You could pick official hex codes or something close:
bucks_green <- "#00471B"
bucks_cream <- "#EEE1C6"

ggplot() +
  # Draw the court first
  draw_half_court(line_color = "black", court_background = "white") +
  # Plot shots
  geom_point(
    data = shots2019,
    aes(x = locationX, y = locationY, color = isShotMade),
    alpha = 0.6,
    size = 2
  ) +
  coord_fixed() +  # keep aspect ratio consistent
  scale_color_manual(
    values = c("FALSE" = bucks_green, "TRUE" = bucks_cream),
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




