library(shiny)
library(leaflet)
library(dplyr)
library(tidyr)
library(tidyverse)


df = read.csv("./completed_dataset.csv", stringsAsFactors = F)



saveRDS(df, "./df.rds")
