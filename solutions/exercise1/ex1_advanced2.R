# ADVANCED EXERCISE 2
# What is the minimum temperature?
# Can you plot
#    the min temperature vs max temperature
#    min AND max temp in a plot?

sstmin <- load_layers("BO_sstmin")
North_Atl_sf$BO_sstmin <- extract(sstmin,North_Atl_sf)

# scatterplot
ggplot(data = North_Atl_sf,
       aes(x = BO_sstmin,
           y = BO_sstmax,
           color = Lat)) +
  geom_point()

# similar graph along latitudes:
ggplot(data = North_Atl_sf) +
  geom_point(aes(x = Lat,
                 y = BO_sstmax,
                 color = BO_sstmax)) +
  geom_line(aes(x = Lat,
                y = BO_sstmax,
                color = BO_sstmax)) +
  geom_point(aes(x = Lat,
                 y = BO_sstmin,
                 color = BO_sstmin)) +
  geom_line(aes(x = Lat,
                y = BO_sstmin,
                color = BO_sstmin)) +
  scale_color_viridis_c(option = 'inferno') +
  theme_dark()
