# Exercise 3
# Can you see a trend in Lesser Black-backed Gull observations in the North Sea?

ggplot(Larus_fuscus_NZ_sf) +
  geom_histogram(aes(x = yearcollected))

# this will create by default 30 bins
# if you want it by year, you can for example use the year as a factor:

ggplot(Larus_fuscus_NZ_sf) +
  geom_histogram(aes(x = as.character(yearcollected)), stat = "count")
