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