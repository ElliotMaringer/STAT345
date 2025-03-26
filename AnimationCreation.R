AnimationCreation <- function(startSeason, endSeason) {
  seasons <- startSeason:endSeason
  num_seasons <- length(seasons)
  nframes <- 20 * num_seasons
  
  allSeasonsBucks <- map_dfr(seasons, ~teams_shots(teams = "Milwaukee Bucks", team_ids = NULL,
                                                   all_active_teams = F, season_types = "Regular Season", seasons = .x,
                                                   measures = "FGA", periods = 0, months = 0, date_from = NA,
                                                   date_to = NA, nest_data = F, return_message = T) 
  )
  
  AllSeasonsHalf <- filter(allSeasonsBucks, allSeasonsBucks$locationY < 400)
  animation <- ggplot() +
    # Draw the court first
    draw_half_court(line_color = "black", court_background = "white") +
    # Plot shots
    geom_point(
      data = AllSeasonsHalf,
      aes(x = locationX, y = locationY, color = isShotMade),
      alpha = 0.1,
      size = 2
    ) +
    coord_fixed() +  # keep aspect ratio consistent
    scale_color_manual(
      values = c("FALSE" = "red", "TRUE" = bucks_green),
      name = "Shot Result",
      labels = c("FALSE" = "Miss", "TRUE" = "Make")
    ) +
    labs(
      title = paste0("Milwaukee Bucks Shot Locations from ", startSeason, " to ", endSeason),
      subtitle = "Colored by shot outcome",
      x = NULL,
      y = NULL
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 20, face = "bold", hjust = .5),
      plot.subtitle = element_text(size = 15, hjust = .5),
      legend.title = element_text(size = 12, face = "bold"),
      legend.text = element_text(size = 10),
      legend.position = "bottom",
      panel.background = element_rect(fill = "white", color = NA),
      plot.background = element_rect(fill = "white", color = NA)
    ) +
    guides(color = guide_legend(override.aes = list(alpha = 1, size = 4))) +
    transition_states(yearSeason, transition_length = 1, state_length = 2) 
  
  animationFinal <- animate(animation, nframes = nframes, fps = 5)
  return(animationFinal)
}
