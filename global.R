library(shiny)
library(leaflet)
library(DT)
library(dplyr)
library(stringr)

#les dataset utilisés :
df <- readRDS("./df.rds")
pop_data <- read.csv("population_per1000.csv", sep = ',', stringsAsFactors = F)
birthrate_data <- read.csv("Birthrate.csv", sep = ',', stringsAsFactors = F)
deathrate_data <- read.csv("Deathrate.csv", sep = ',', stringsAsFactors = F)
net_migration_data <- read.csv("migration_nette.csv", sep = ',', stringsAsFactors = F)
predict_data <- read.csv("predict_data.csv", sep = ',', stringsAsFactors = F)

list_input_maping <- list("Population", "Deathrate", "Birthrate")
list_input <- list("AFRICA", "AMERICA", "ASIA", "EUROPE", "OCEANIA")
list_norms <- list("Population", "Deathrate", "Birthrate", "Migration nette")
list_years <- c(as.character(seq(1960, 2017, 1)))
list_years_for_migration <- c(as.character(seq(1962, 2017, 5)))
list_years_numeric <- seq(1960, 2017, 1)
#list_radioButtonsChoices <- c("Une année précise", "Toutes les années")

#les fonctions utilisées :
over_years <- function(x, dataused){
  vector = c()
  i <- 264
  while (i>0) {
    if(str_detect(dataused[i,1], x) == TRUE){
      for (j in 5:62) {
        vector <- c(vector, dataused[i,j])
      }
      return(vector)
    }
    i <- i-1
  }
}

colnamyze <- function(v){
  v <- as.character(v)
  for(i in 0:length(v)){
    v[i] <- paste0("X", v[i])
  }
  return(v)
}

predict_population <- function(t, country){
  i <- 264
  while(i>0){
    if(str_detect(predict_data[i,1], country) == TRUE){
      p0 <- predict_data[i,2]/1000
      pn <- p0 * exp(predict_data[i,3]*(t-2017))
      return(pn)
    }
    i <- i-1
  }
}






#les dataframes crees :



