data<-read.csv("ColombiaBirdMorphologyPhenology.csv", header = T)
attach(data)

names(data)

#Species covered
species<-unique(data$scientificName)
species
length(species)

#Families covered
families<-unique(data$family)
families
length(families)

#Setting geographic coordinates space
min(data$decimalLatitude)
max(data$decimalLatitude)
min(data$decimalLongitude)
max(data$decimalLongitude)

library(maps)
library(mapdata)
library(maptools)
library(mapproj)
map(database= "world", ylim=c(4.9, 5.7), xlim=c(-74.5, -76), col="grey80", fill=TRUE, projection="gilbert", orientation= c(90,0,225))
lon <- (data$decimalLongitude)
lat <- (data$decimalLatitude)
coord <- mapproject(lon, lat, proj="gilbert", orientation=c(90, 0, 225))  #convert points to projected lat/long
points(coord, pch=20, cex=1.2, col="red")  #plot converted points

#Trying another map option (doesn't work due to Google API)
library(ggplot2)
library(ggmap)

df <- as.data.frame(cbind(lon,lat))

# getting the map
mapbirds <- ggmap(
  get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 4,
                      maptype = "satellite", source = "google", scale = 2)
)

# plotting the map with some points on it
ggmap(mapbirds) +
  geom_point(data = df, aes(x = lon, y = lat, fill = "red", alpha = 0.8), size = 5, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)

library(sp)
library(leaflet)
df <- as.data.frame(cbind(lon,lat))
coordinates(df) <- ~lon+lat
leaflet(df) %>% addMarkers() %>% addTiles()

#With Google Maps....
library(RgoogleMaps)
centre = c(mean(lat), mean(lon))  #tell what point to center on
zoom <- 2 #zoom: 1 = furthest out (entire globe), larger numbers = closer in
terrmap <- GetMap(center=centre, zoom=zoom, type= "satellite", destfile = "satellite.png")
