## 10Feb2021
## Unit 2.6: Arctic Sea Ice


## I want to read in this infomation about sea ice from the Sea Ice Index. The Sea Ice Index
## provides a quick look at Arctic- and Antarctic-wide changes in long-term sea ice cover 
## derived from satellite data. We're going to download, read, and plot the data. 

## Underneath this, in hashtags, is how we would read in the data file from a .csv file, and
## reading it in from a url. 

## arctic_ice = read.csv("data/N_seaice_extent_daily_v3.0.csv", skip=2, header = FALSE, 
## col.names = c("Year", "Month", "Day", "Extent", "Missing", "Source_Data"))
url = 'ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v3.0.csv'
arctic_ice = read.delim(url, skip=2, sep=",", header=FALSE, col.names = c("Year", "Month", "Day", 
                                                                          "Extent", "Missing", "Source_Data"))
head(arctic_ice)

## So looking at this data, we are not provided with the decimal_date column. We're going
## to have to create a column with that, especially because we want to plot a time series, 
## and we can only plot one variable along the x-axis. We could do the math, but that 
## sounds annoying as hell. So let's use the lubridate package that was designed by other
## R users. So first let's install this ish.


install.packages("lubridate")
## We could also have installed it from the Tools menu (-> Install packages...)

## Now that lubridate is installed, we want to load the package functions into the environment
## with the library() function. Now we can use the function make_date() to transform year, month,
## and day into a date type variable. 
library("lubridate")

?make_date

## So in this case, we want to make a new column in our arctic_ice data set using our make_date
## function. It goes make_date(year, month, day), and we can just make a fresh column with it. 
## That's convenient as fuck.

arctic_ice$date = make_date(arctic_ice$Year, arctic_ice$Month, arctic_ice$Day)

head(arctic_ice)
## Okay, so this just ordered it in terms of the following date format: year-month-day. 
## Interesting. How will it plot?

plot(Extent ~ date, data=arctic_ice, ylab="Arctic sea ice extent (x10^6 km^2)", type='l') 


## Now I want to use for loops to calculate the annual average Arctic sea ice extent and the 
## 5-year-average Arctic sea ice extent. The annual average is the mean of all the sea ice
## extent observations within a given year. We'll define the 5-year-average ice extent for some
## given year x as the mean of all sea ice exten observations within the year x as well as the 2
## years prior and the 2 years after year x. For example, the 5-year-average sea ice extent for 
## 2010 is the mean of all observations from Jan. 1 2008 to Dec. 31 2012. 

## Okay, so here we're creating a new dataframe for the annual extent of the arctic ice with
## our years, the average annual extent, and the 5 year average extent.
arctic_ice_annual = data.frame(Year=seq(min(arctic_ice$Year), max(arctic_ice$Year)), 
                               extent_annual_avg=NA, extent_5yr_avg=NA)
head(arctic_ice_annual)


## Now we're going to hard-code the years and put them into our new data frame using for loops.
## Calculating the annual average. In this chunk of code, my iterand is the number of years that
## I've specified in my new arctic_ice_annual. I'm using the sequence, starting with the number 
## of rows (dim) in my first column [1] of my dataframe arctic_ice_annual. Then I'm defining my 
## column extent_annual_avg of the [i]th iterand as the average of the arctic_ice data for all
## the values (which function) in which the year is equal to my iterand, and I want the data from
## the 'Extent' column, so I'm specifying that. Holy shit woof. I mean, this is cool but yikes
## on several fucking bikes who had the time to come up with these functions! God bless their
## souls. 
for (i in seq(dim(arctic_ice_annual)[1]))
{
  arctic_ice_annual$extent_annual_avg[i] = mean(arctic_ice[which(arctic_ice$Year == 
                                                                   arctic_ice_annual$Year[i]),
                                                           'Extent'])
}

head(arctic_ice_annual)

## Now for calculating the 5-year average. I'm stating that my iterand is the sequence between 
## 3 and the dimensions of the first column of arctic_ice_annual - 2. This means that I'm going 
## to be designating the iterand to be the sequence between 3 and 42. I want this because to 
## fill in the 5 year value, I want the specific year, starting at the 3rd year in our arctic_ice
## data set, then subtracting two and adding two, but having the mean over those five years.
## In my for loop, I'm also naming the element years, which is the 5 year span, then using it 
## in a logic argument for calculating the average for all of the values that have a year value 
## in their Year column that is in our years element. Clever, clever. We're also making sure to 
## specify in our which argument that we want the 'Extent' column information, and that's what
## we're averaging. 
for (i in seq(3, dim(arctic_ice_annual)[1]-2))
{
  years = c((arctic_ice_annual$Year[i]-2):(arctic_ice_annual$Year[i]+2))
  arctic_ice_annual$extent_5yr_avg[i] = mean(arctic_ice[which(arctic_ice$Year %in% years),'Extent'])
}

?seq
seq(3, dim(arctic_ice_annual)[1]-2)

## Now let's plot this ish!! :)

pdf('figures/arctic_ice_extent.pdf', width=7, height=5)
plot(extent_annual_avg ~ Year, data=arctic_ice_annual, col="red", type="l") +
  lines(extent_5yr_avg ~ Year, data=arctic_ice_annual, col="blue", type="l")
dev.off()

## Hmm, my red line tail is wwaaayyyy off. I bet my data set has something slightly different 
## at the end that what Erin originally used. I'm gonna investigate. 

tail(arctic_ice_annual)

## Yeah, my extent_annual_avg for 2021 is pretty big -- that's because we have more icy data
## in 2021 because we're only in February. I want to exclude those points. But I'm not really 
## sure how. Welp. Normally I would subset this and fix it, but I've got more lessons to get
## through. 


## Now I want to graph the 5-year-average and annual extent on the same plot as the 
## original observations. First, we'll have to change the Year variable into a date-type
## variable that will plot well along the dates in the original observation dataset. 

## To plot the annual and 5-year averages on the same plot as the original observations, 
## first, I'm adding the date column to the arctic_ice_annual dataset, but making each 
## annual observation read as though it was collected on the first. This smooths things 
## out pretty well. 
arctic_ice_annual$date = as.Date(paste(arctic_ice_annual$Year, 1, 1, sep = "-"))
plot(Extent ~ date, data=arctic_ice, ylab="Arctic sea ice extent (x10^6 km^2)", type='l') +
  lines(extent_annual_avg ~ date, data=arctic_ice_annual, col="red") +
  lines(extent_5yr_avg ~ date, data=arctic_ice_annual, col="blue")

head(arctic_ice_annual)


## Now I want to calculate the observed rate of change in annually averaged ice extent across
## the time period by subtracting the first average Arctic ice extent area from the most recent
## average Arctic ice extent area, and dividing by the number of years of observation. 

ice_loss_million_km2 = (arctic_ice_annual$extent_annual_avg[dim(arctic_ice_annual)[1]] - 
                          arctic_ice_annual$extent_annual_avg[1]) / 
          (max(arctic_ice_annual$Year) - min(arctic_ice_annual$Year))
ice_loss_million_km2

## I got a different answer than her because my 2021 data is very high. But I don't have the
## energy to fix or subset that data right now, so fukkkkk it.

## Exercise 6.1:
## Use a for loop to calculate the total ice loss in each full decate of the data, starting 
## with 1980-1989. Plot the ice loss per decade in a bar plot. 

## Okay, so first I want to subset only the years that I need. 
ice_decades = arctic_ice_annual[which(arctic_ice_annual$Year >= 1980 & arctic_ice_annual$Year < 2020),]
summary(ice_decades)

## Now I want to initialize my results data frame.
n_decades = dim(ice_decades)[1]/10
decadal_loss = data.frame(decade = seq(n_decades),
                          decade_name = c("1980s", "1990s", "2000s", "2010s"),
                          ice_loss_million_km2 = NA)

## Now I'm going to set up my for loop. I'm going to step through my iterand (each decade) and
## calculate the difference in ice extent between the first and last year.
for (i in seq(n_decades)){
  print(paste("index from ", (i-1)*10+1, " to ", (i-1)*10 + 10))
  decadal_loss$ice_loss_million_km2[i] = ice_decades$extent_annual_avg[(i-1)*10+1] -
    ice_decades$extent_annual_avg[(i-1)*10 +10]
}

## Now to plot. 
barplot(height=decadal_loss$ice_loss_million_km2, names.arg=decadal_loss$decade_name,
        ylab="Arctic ice loss (million km^2)")


