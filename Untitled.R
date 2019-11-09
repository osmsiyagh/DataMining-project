
data <- read.csv("countries of the world.csv", sep = ',', stringsAsFactors = F)
#View(data)

coord <- read.csv("countries_data.csv", sep = ',', stringsAsFactors = F)
#View(Coord)


data$Country = substr(data$Country,1,nchar(data$Country)-1)

new_data_frame <- inner_join( coord, data, by='Country')

#View(new_data_frame)


write.table(new_data_frame, "completed_dataset.csv", row.names=FALSE, sep=",")

#View(data)




########### REGION :
library(stringr)
data1 <- read.csv("completed_dataset.csv", sep = ',', stringsAsFactors = F)
View(data1)

i <- 142
while(i>0){
  if(data1[i,4] = "LATIN AMER. & CARIB" || data[i,4] <- "NORTHERN AMERICA") data1[i,4] <- "America"
  else if(data1[i,4] = "C.W. OF IND. STATES" || data[i,4] <- "NEAR EAST") data1[i,4] <- "Asia / Europe"
  else if(data1[i,4] = "EASTERN EUROPE" || data1[i,4] = "WESTERN EUROPE") data1[i,4] <- "Europe"
  else if(data1[i,4] = "ASIA (EX. NEAR EAST)") data1[i,4] <- "Asia"
  else if(data1[i,4] = "OCEANIA") data1[i,4] <- "Oceania"
  else if(data1[i,4] = "SUB-SAHARAN AFRICA" || data1[i,4] = "SUB-SAHARAN AFRICA") data1[i,4] <- "Africa"
  i <- i-1
}


View(list_years)

###
#for (i in 5:62) {
#  names(pop_data)[i] <- substring(names(pop_data)[i], 2)
#}
#write.table(pop_data, "population.csv", row.names=FALSE, sep=",")

#for (i in 5:62) {
 # names(birthrate_data)[i] <- substring(names(birthrate_data)[i], 2)
#}
#write.table(birthrate_data, "Birthrate.csv", row.names=FALSE, sep=",")

#for (i in 5:62) {
 # names(deathrate_data)[i] <- substring(names(deathrate_data)[i], 2)
#}
#write.table(deathrate_data, "Deathrate.csv", row.names=FALSE, sep=",")


# must write it at end
#pop_data <- pop_data[order(pop_data$Country.Name),]
#birthrate_data <- birthrate_data[order(birthrate_data$Country.Name),]
#deathrate_data <- deathrate_data[order(deathrate_data$Country.Name),]
#deathrate_data <- deathrate_data[order(deathrate_data$Country.Name),]
#net_migration_data <- net_migration_data[order(net_migration_data$Country.Name),]
View(birthrate_data)
View(deathrate_data)
View(pop_data)
View(net_migration_data)

#write.table(net_migration_data, "migration_nette.csv", row.names=FALSE, sep=",")


#dataframe cree
#
#predict_data <- data.frame("Country" = pop_data[,1], "Recent value" = pop_data[,62], "r" = (birthrate_data[,62]-deathrate_data[,62])/100 )
#write.table(predict_data, "predict_data.csv", row.names=FALSE, sep=",")






#rename the rows :
#rownames(pop_data) <- pop_data[,1]
#rownames(birthrate_data) <- birthrate_data[,1]
#rownames(deathrate_data) <- deathrate_data[,1]
#rownames(net_migration_data) <- net_migration_data[,1]


#population per 1000:
a <- pop_data

i <- 264
while (i>0) {
    for (j in 5:62) {
      a[i,j] <- a[i,j]/1000
    }
    i <- i-1
  }
write.table(a, "population_per1000.csv", row.names=FALSE, sep=",")  
#View(a)




