### Hayes 2017 - Temporal patterns of invasion analysis

## Creating maps for each species with locations.

## Mark A. Hayes
## July 3, 2017

## Showing the steps in making a simple map with occurrence locations. 

# House keeping as needed.

remove() # Remove any object left over from previous analyses, as desired, or... 
rm(list=ls()) # ...remove all items from global environment

## Step 1. Pull in a csv file to use and name the latitude and longitude columns.
## Using the "noDups" csvs:

data = read.table(file.choose(), header=TRUE, sep=",") # Choose the csv to use (e.g., agag_noDups.csv).
data
summary(data)

lat <- data$lat
lon <- data$lon

## Step 2. Create a map of the SE U.S. focusing on Florida.

library(maps)
library(mapdata)

# The following map starts with the coastline of the SE U.S. Change xlim and ylim as desired. 

# For Florida closeup:  ylim = c(24,32), xlim = c(-76,-89)

map("usa", xlim = c(-89,-76), ylim = c(24,32), col = "gray90", fill = TRUE) # Just coastline

map('state', xlim = c(-89,-76), ylim = c(24,32), fill = FALSE) # Includes state boundaries

## Step 3. Plot points

points(lon, lat, pch=19, col="black", cex=0.5)  #plot my EDDMapS locations

## Print the map as a tiff

dev.print(tiff, "map.tiff", height=4, width=6, units='in', res=600)

## Full code for producing and printing a map, with state boundaries and locs. 
## Change name in the tiff file name as needed.

data = read.table(file.choose(), header=TRUE, sep=",") # (e.g., agag_noDups.csv).
summary(data)

lat <- data$lat
lon <- data$lon

map('state', xlim = c(-89,-76), ylim = c(24,32), fill = FALSE) # Includes state boundaries
points(lon, lat, pch=19, col="black", cex=0.5)  #plot my EDDMapS locations
dev.print(tiff, "map_agag.tiff", height=4, width=6, units='in', res=600)


## Record results as desired. 
## Repeat as necessary. 

## End.

