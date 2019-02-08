### 3.1 Data access in EMODnet Biology
### 3.2 Data loading in R

# Prepare the R environment by loading the packages that we'll need:

library(data.table)
library(ggplot2)
library(sf)
library(dplyr)
library(mapview)

# Then load the downloaded file
fname <- 'data/20190208_Larus_fuscus_NZ_EMODnetBio.csv'
Larus_fuscus_NZ <- fread(fname,
                    header = TRUE,
                    sep = ',')

# convert to a spatial object
Larus_fuscus_NZ_sf <- st_as_sf(Larus_fuscus_NZ,
                        coords = c("longitude", "latitude"),
                        crs = 4326)

### 3.2 Data visualization
  # base plot
  plot(st_geometry(Larus_fuscus_NZ_sf), axes = TRUE)

  # Plot data in ggplot, color by month
  if (utils::packageVersion("ggplot2") > "2.2.1"){
  ggplot() +
      geom_sf(data=Larus_fuscus_NZ_sf,
      aes(colour=monthcollected))
  }

  # for faster performance in this tutorial, we select only a part:
  # long: 0-5°
  # lat: 50-52°
  selectbox <- st_polygon(list(rbind(c(0,50), c(0,52), c(5,52), c(5,50), c(0,50))))
  selectbox <- st_sfc(selectbox, crs = 4326)

  Larus_fuscus_sel <- Larus_fuscus_NZ_sf %>%
  filter(st_intersects(., selectbox, sparse = FALSE))


  # you can create interactive maps with the mapview package:
  # more info: https://github.com/r-spatial/mapview
  mapview(Larus_fuscus_NZ_sf,
            zcol = 'yearcollected',
            cex = 3, lwd = 0.5,
            legend = TRUE,
            viewer.suppress = FALSE)


### Exercise

# Can you see a trend in Lesser Black-backed Gull observations in the North Sea over the years?
# In which year there were the most observations?
