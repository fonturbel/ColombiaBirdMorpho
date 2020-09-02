##This short script will help you getting hands-on with the database
##and obtain basic information from the data file

#Load the database
data<-read.csv("ColombiaBirdMorphologyPhenology.csv", header = T)
attach(data)

head(data)

#Species covered
species<-unique(data$scientificName)
species
length(species)

#Genera covered
genera<-unique(data$genus)
genera
length(genera)

#Families covered
families<-unique(data$family)
families
length(families)

#Setting geographic coordinates space
min(data$decimalLatitude)
max(data$decimalLatitude)
min(data$decimalLongitude)
max(data$decimalLongitude)

#Ploting a simple map, locating the sampling points in Colombia
library(maps)
library(mapdata)
library(maptools)
library(mapproj)
map(database= "world", ylim=c(4.9, 5.7), xlim=c(-74.5, -76), col="darkgoldenrod1", fill=TRUE, projection="gilbert", orientation= c(90,0,225))
lon <- (data$decimalLongitude)
lat <- (data$decimalLatitude)
coord <- mapproject(lon, lat, proj="gilbert", orientation=c(90, 0, 225))  #convert points to projected lat/long
points(coord, pch=20, cex=1.2, col="red")  #plot converted points

#Trying another map option (doesn't work due to Google API)
library(ggplot2)
library(ggmap)

df <- as.data.frame(cbind(lon,lat))

# getting the map

library(sp)
library(leaflet)
df <- as.data.frame(cbind(lon,lat))
coordinates(df) <- ~lon+lat
leaflet(df) %>% addMarkers() %>% addTiles()