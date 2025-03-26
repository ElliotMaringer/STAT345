
library(devtools)
library(nbastatR)
library(dplyr)
library(ggplot2)
library(purrr)
library(gganimate)
devtools::install_github("abresler/nbastatR")
devtools::install_github("abresler/nbastatR", force = TRUE)

Sys.setenv("VROOM_CONNECTION_SIZE" = 500000)


bucks_green <- "#00471B"
bucks_cream <- "#EEE1C6"


SingleSeasonPlot(shots2015, "Half")
AnimationCreation(2000, 2019)






