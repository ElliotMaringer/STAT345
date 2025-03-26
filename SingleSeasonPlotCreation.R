## Plot creation for a single season
SingleSeasonPlot <- function(data, type) {
  bucks_green <- "#00471B"
  bucks_cream <- "#EEE1C6"
  if (type == "Half") {
  halfCourtShots <- filter(data, data$locationY < 400)
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
      name = "Shot Result",
      labels = c("FALSE" = "Miss", "TRUE" = "Make")
    ) +
    labs(
      title = "Milwaukee Bucks Shot Locations (2019 Season)",
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
    guides(color = guide_legend(override.aes = list(alpha = 1, size = 4)))
  } 
  if (type == "Full") {
    
    ##Full Court Shot Chart
    
    ggplot() +
      # Draw the court first
      draw_court(line_color = "black", court_background = "white") +
      # Plot shots
      geom_point(
        data = data,
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
  }
}
