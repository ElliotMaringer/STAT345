AnimationCreation <- function(data, startSeason, endSeason) {
  seasons <- startSeason:endSeason
  
  AllSeasonsHalf <- filter(data, data$locationY < 400)
  ggplot() +
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
      title = "Milwaukee Bucks Shot Locations",
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
    transition_states(yearSeason, transition_length = 10, state_length = 5) 
}