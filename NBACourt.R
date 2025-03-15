## This function draws an nba court on ggplot

draw_half_court <- function(line_color = "#000000", court_background = "white") {
  list(
    # Court background (half-court: x from -250 to 250, y from 0 to 470)
    annotate("rect",
             xmin = -250, xmax = 250,
             ymin = 0,    ymax = 800,
             fill = court_background, color = line_color),
    
    
    
    # half court line
    annotate("segment", x = -250, xend = 250, y = 400,   yend = 400,   color = line_color),
    
    
    # Free throw lane
    annotate("rect",
             xmin = -80, xmax = 80,
             ymin = 0,   ymax = 190,
             fill = NA, color = line_color),
    
    # Free throw circle (top half)
    
    annotate(
      "path",
      x = 80 * cos(seq(0, 2*pi, length.out = 200)),
      y = 190 + 80 * sin(seq(0, 2*pi, length.out = 200)),
      color = line_color),
    
    
    
    # Rim (circle at center = (0, 60))
    annotate("path",
             x = 7.5 * cos(seq(0, 2*pi, length.out = 100)),
             y = 45 + 7.5 * sin(seq(0, 2*pi, length.out = 100)),
             color = "orange", size = 1.2),
    
    # Backboard (just above the rim)
    annotate("segment",
             x = -30, xend = 30,
             y = 45,  yend = 45,
             color = line_color, size = 1.5),
    
    
    
    annotate("segment",
             x = -230, xend = -230,
             y = 0,  yend = 70,
             color = line_color),
    
    annotate("segment",
             x = 230, xend = 230,
             y = 0,  yend = 70,
             color = line_color),
    
    annotate(
      "path",
      x = 230 * cos(seq(0, pi, length.out = 200)),
      y = 70 + 230 * sin(seq(0, pi, length.out = 200)),
      color = line_color
      
    )
  )
  
  
}