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