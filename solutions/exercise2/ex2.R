# How many times was the Cadmium threshold exceeded in 2015?
cd_data_sf_2015[cd_data_sf_2015$Exceeded ==1,]
sum(cd_data_sf_2015$Exceeded)
