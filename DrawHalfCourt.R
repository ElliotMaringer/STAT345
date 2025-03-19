## This function draws an nba court on ggplot

draw_half_court <- function(line_color = "#000000", court_background = "white") {
  list(
    # Court background (half-court: x from -250 to 250, y from 0 to 470)
    annotate("rect",
             xmin = -250, xmax = 250,
             ymin = -30,    ymax = 400,
             fill = court_background, color = line_color),
    
    
    
    # half court line
    annotate("segment", x = -250, xend = 250, y = 400,   yend = 400,   color = line_color),
    
    
    # Free throw lane
    annotate("rect",
             xmin = -70, xmax = 70,
             ymin = -30,   ymax = 160,
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
             y = -30,  yend = 35,
             color = line_color),
    
    annotate("segment",
             x = 220, xend = 220,
             y = -30,  yend = 35,
             color = line_color),
    
    annotate(
      "path",
      x = 220 * cos(seq(0, pi, length.out = 200)),
      y = 35 + 220 * sin(seq(0, pi, length.out = 200)),
      color = line_color
      
    )
  )
  
  
}
