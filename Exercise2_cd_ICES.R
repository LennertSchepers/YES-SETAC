### 2.2. Data analysis in R
#First, we load some R packages that we will use in this exercise

library(dplyr)      # package for data manipulation
library(data.table) # package for fast reading of csv files
library(sf)         # simple features
library(mapview)    # interactive maps
library(ggplot2)    # plotting


# read the data:
cd_data <- read.csv("data/20190208_Cd_data_ICES.csv")
head(cd_data)

# it seems that there are different units used in this dataset!
# create table with unit occurrences
table(cd_data$Unit)

# manual conversion
cd_data <- cd_data %>%
  mutate(ugkg = case_when( Unit == 'ug/g'  ~ Value * 1000,
                           Unit == 'mg/kg' ~ Value * 1000,
                           Unit == 'g/g'   ~ Value * 1E9,
                           Unit == 'ug/kg' ~ Value
                           ),
         Exceeded = as.numeric(ugkg >= 1200)
  )

# convert to spatial (simple feature)
cd_data_sf <- st_as_sf(cd_data,
                       coords=c("Longitude..degrees_east.","Latitude..degrees_north."),
                       crs = 4326, # WGS84
                       remove = FALSE)

#Plot the data:
mapview(cd_data_sf, zcol = "Exceeded",
        viewer.suppress = FALSE)

# Now, what was the question? How many times is it exceeded in 2015?
cd_data_sf$Date_posixct <- as.POSIXct(cd_data_sf$dd.mm.yyyyThh.mm.ss,
                                             format = "%d/%m/%Y %H:%M",
                                             tz = "UTC")

# quick check of the data
ggplot(cd_data_sf) +
  geom_histogram(aes(x = Date_posixct))

#Subset the data to only include 2015: 
cd_data_sf_2015 <- cd_data_sf %>%
  filter(Date_posixct > as.POSIXct("2015-01-01 01:00:00", tz="UTC") &
         Date_posixct < as.POSIXct("2016-01-01 01:00:00", tz="UTC"))

# plotting the data
ggplot(cd_data_sf_2015) +
  geom_point(aes(x = Date_posixct, y = ugkg)) +
  geom_hline(yintercept =1200, color = "red")

# some more interactive plots:
mapview(cd_data_sf_2015, zcol = "Exceeded",
        viewer.suppress = FALSE) # to view in RStudio

# where are the threshold values exceeded?
mapview(cd_data_sf_2015[cd_data_sf_2015$Exceeded ==1,], zcol = "Exceeded",
        viewer.suppress = FALSE) # to view in RStudio

#So can you answer the question?
#### Exercise 1: How many times was the Cadmium threshold exceeded in 2015?
#### Advanced exercises
# In which estuaries are these located (look up on map)
# In which year are the most exceedances?
