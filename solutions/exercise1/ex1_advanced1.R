# ADVANCED EXERCISE 1
# what is the temperature at different latitudes in the North Atlantic?
# e.g. at longitude -30, latitude from 0 to 60?

North_Atl <- data.frame(
  Lat = seq(from = 0, to = 60, by = 5),
  Lon = -30)

North_Atl_sf <- st_as_sf(North_Atl,
                         coords=c("Lon","Lat"),
                         crs = 4326,
                         remove = FALSE)

mapview(sstmax, layer.name = "max sst") +
  mapview(North_Atl_sf)

North_Atl_sf$BO_sstmax <- extract(sstmax,North_Atl_sf)

ggplot(data = North_Atl_sf,
       aes(x = Lat,
           y = BO_sstmax,
           color = BO_sstmax)) +
  geom_point() +
  geom_line()+
  scale_color_viridis_c(option = 'inferno') +
  theme_dark()
