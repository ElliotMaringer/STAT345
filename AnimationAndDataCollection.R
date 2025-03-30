library(devtools)
library(nbastatR)
library(dplyr)
library(ggplot2)
library(purrr)
library(gganimate)
devtools::install_github("abresler/nbastatR", force = TRUE)

Sys.setenv("VROOM_CONNECTION_SIZE" = 500000)

bucks_green <- "#00471B"

## This function creates an animated shot chart of the Milwaukee Bucks for a provided range of season
## Inputs: (startSeason, endSeason) provides the range of years the data will be collected from
## Outputs: Animated plot of the Milwaukee Bucks shot selection over given years
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
    # Draw the court 
    draw_half_court(line_color = "black", court_background = "white") +
    # Plot shots
    geom_point(
      data = AllSeasonsHalf,
      aes(x = locationX, y = locationY, color = isShotMade),
      alpha = 0.1,
      size = 2
    ) +
    coord_fixed() + 
    scale_color_manual(
      values = c("FALSE" = "red", "TRUE" = bucks_green),
      name = "Shot Result",
      labels = c("FALSE" = "Miss", "TRUE" = "Make")
    ) +
    labs(
      title = paste0("Milwaukee Bucks Shot Locations from ", startSeason, " to ", endSeason),
      subtitle = "Season: {closest_state}",
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

## This function draws an NBA half court on ggplot

draw_half_court <- function(line_color = "#000000", court_background = "white") {
  list(
    # Court background 
    annotate("rect",
             xmin = -250, xmax = 250,
             ymin = -40,    ymax = 400,
             fill = court_background, color = line_color),
    
    
    
    # half court line
    annotate("segment", x = -250, xend = 250, y = 400,   yend = 400,   color = line_color),
    
    
    # Free throw lane
    annotate("rect",
             xmin = -70, xmax = 70,
             ymin = -40,   ymax = 160,
             fill = NA, color = line_color),
    
    # Free throw circle 
    
    annotate(
      "path",
      x = 70* cos(seq(0, 2*pi, length.out = 200)),
      y = 160 +  70* sin(seq(0, 2*pi, length.out = 200)),
      color = line_color),
    
    #Middle circle
    annotate(
      "path",
      x = 60 * cos(seq(pi, 2*pi, length.out = 200)),
      y = 400 + 60 * sin(seq(pi, 2*pi, length.out = 200)),
      color = line_color),
    
    
    
    # Rim 
    annotate("path",
             x = 7.5 * cos(seq(0, 2*pi, length.out = 100)),
             y = 7.5 * sin(seq(0, 2*pi, length.out = 100)),
             color = "orange", size = 1.2),
    
    # Backboard 
    annotate("segment",
             x = -30, xend = 30,
             y = 0,  yend = 0,
             color = line_color, size = 1.5),
    
    #Three point line
    
    annotate("segment",
             x = -220, xend = -220,
             y = -40,  yend = 35,
             color = line_color),
    
    annotate("segment",
             x = 220, xend = 220,
             y = -40,  yend = 35,
             color = line_color),
    
    annotate(
      "path",
      x = 220 * cos(seq(0, pi, length.out = 200)),
      y = 35 + 220 * sin(seq(0, pi, length.out = 200)),
      color = line_color
      
    )
  )
  
  
}

