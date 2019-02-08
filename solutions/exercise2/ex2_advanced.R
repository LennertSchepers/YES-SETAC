# Exercise 2 ADVANCED EXERCISES
# in which estuaries are these located (look up on map)
# in which year are the most exceedances?

cd_data_exceeded <- cd_data_sf %>%
  filter(Exceeded == 1)

# extract year in a new column
cd_data_exceeded <- cd_data_exceeded %>%
  mutate(year = format(Date_posixct, format = "%Y"))

ggplot(cd_data_exceeded) +
  geom_histogram(aes(x=year), stat = "count")
