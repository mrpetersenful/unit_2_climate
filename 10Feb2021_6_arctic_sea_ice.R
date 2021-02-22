## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.asp = 0.618, collapse=TRUE) 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# arctic_ice = read.csv("data/N_seaice_extent_daily_v3.0.csv", skip=2, header = FALSE, col.names = c("Year", "Month", "Day", "Extent", "Missing", "Source_Data"))
url = 'ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v3.0.csv'
arctic_ice = read.delim(url, skip=2, sep=",", header=FALSE, col.names = c("Year", "Month", "Day", "Extent", "Missing", "Source_Data"))
head(arctic_ice)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# install.packages("lubridate")
library("lubridate")  # make_date()

arctic_ice$date = make_date(arctic_ice$Year, arctic_ice$Month, arctic_ice$Day)
plot(Extent ~ date, data=arctic_ice, ylab="Arctic sea ice extent (x10^6 km^2)", type='l') 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
arctic_ice_annual = data.frame(Year=seq(min(arctic_ice$Year), max(arctic_ice$Year)), extent_annual_avg=NA, extent_5yr_avg=NA)
head(arctic_ice_annual)
# Hard-coding the years
# calculate annual average:
for (i in seq(dim(arctic_ice_annual)[1]))
{
  arctic_ice_annual$extent_annual_avg[i] = mean(arctic_ice[which(arctic_ice$Year == arctic_ice_annual$Year[i]),'Extent'])
}

# 5-year average:
for (i in seq(3, dim(arctic_ice_annual)[1]-2))
{
  years = c((arctic_ice_annual$Year[i]-2):(arctic_ice_annual$Year[i]+2))
  arctic_ice_annual$extent_5yr_avg[i] = mean(arctic_ice[which(arctic_ice$Year %in% years),'Extent'])
}

# pdf('figures/arctic_ice_extent.pdf', width=7, height=5)
plot(extent_annual_avg ~ Year, data=arctic_ice_annual, col="red", type="l") +
  lines(extent_5yr_avg ~ Year, data=arctic_ice_annual, col="blue", type="l")
# dev.off()


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#To plot the annual and 5-year averages on the same plot as the original observations:
arctic_ice_annual$date = as.Date(paste(arctic_ice_annual$Year, 1, 1, sep = "-"))
plot(Extent ~ date, data=arctic_ice, ylab="Arctic sea ice extent (x10^6 km^2)", type='l') +
  lines(extent_annual_avg ~ date, data=arctic_ice_annual, col="red") +
  lines(extent_5yr_avg ~ date, data=arctic_ice_annual, col="blue")


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
ice_loss_million_km2 = (arctic_ice_annual$extent_annual_avg[dim(arctic_ice_annual)[1]] - arctic_ice_annual$extent_annual_avg[1]) / (max(arctic_ice_annual$Year) - min(arctic_ice_annual$Year))
ice_loss_million_km2

