# course YES-SETAC
# note that this code assumes you are working in RStudio for following functions:
  # View(), mapview()

library(sf) # spatial package
library(ggplot2) # plotting
library(sdmpredictors) # species distribution modeling layers => data layers

# list datasets of sdmpredictors package
list_datasets()
View(list_datasets())
# list layers of Bio-ORACLE dataset
View(list_layers(datasets="Bio-ORACLE"))

sstmax <- load_layers("BO_sstmax")

# base plot
plot(sstmax)

# Make an interactive plot with the 'mapview' package:
# more info: https://r-spatial.github.io/mapview/
library('mapview')
mapview(sstmax) # error: what does it say?
mapview(sstmax, layer.name = "max sst") # warning: what does it say?
mapview(sstmax, layer.name = "max sst", maxpixels =  9331200) # takes long!


my.sites <- data.frame(
  Name = c("Key West", "Barbados", "Porto"),
  Lon = c(-81.775,-59.440,-8.882),
  Lat = c(24.545,13.185,41.130))

# make spatial (simple features) dataset
my.sites.sf <- st_as_sf(my.sites,
                        coords=c("Lon","Lat"),
                        crs = 4326) # WGS84

# base plot
plot(my.sites.sf) # not ideal

# interactive mapview map
mapview(my.sites.sf) # much better

# how to visualize both? combine them with '+'
mapview(sstmax, layer.name = "max sst") +
  mapview(my.sites.sf)

# extract data from sstmax raster at the locations of my.sites.sf
my.sites$BO_sstmax <- extract(sstmax,my.sites.sf)


# plotting data with ggplot2
# https://ggplot2.tidyverse.org/
library(ggplot2)

# points
ggplot(data = my.sites) +
  geom_point(aes(x = Name, y = BO_sstmax))

  # with different colors, a bit larger size
  ggplot(data = my.sites) +
    geom_point(aes(x = Name,
                   y = BO_sstmax,
                   color = BO_sstmax,
                   size = 2)) +
    scale_color_viridis_c(option = 'inferno') # same colorscale as map

# bar plot
ggplot(data = my.sites) +
  geom_col(aes(x = Name, y = BO_sstmax))

  # again different colors, larger size:
  ggplot(data = my.sites) +
    geom_col(aes(x = Name,        # everything inside aes(), will be 'interpreted'
                 y = BO_sstmax,
                 fill = Name),
                 size = 2,
                 color = "black") # color : outline with graphs

  # color by sst max
  ggplot(data = my.sites) +
    geom_col(aes(x = Name,        # everything inside aes(), will be 'interpreted'
                 y = BO_sstmax,
                 fill = BO_sstmax),
             color = "black") +
             scale_fill_viridis_c(option = 'inferno') # color : outline with graphs


# Adjust the code above to include 3 areas of your interest
# e.g. the location closest you your lab?

# ADVANCED EXERCISE 1
# what is the temperature at different latitudes in the North Atlantic?
# e.g. at longitude -30, latitude from 0 to 60?


# ADVANCED EXERCISE 2
# What is the minimum temperature?
# Can you plot
#    the min temperature vs max temperature
#    min AND max temp in a plot?
