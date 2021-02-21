## 3Feb2021
## Lesson 3.4 Examining global atmospheric CO2 trends.



# co2 = read.table("data/co2_mm_mlo.txt", col.names = c("year", "month", 
##      "decimal_date", "monthly_average", "deseasonalized", "n_days", 
##      "st_dev_days", "monthly_mean_uncertainty"))

url = 'ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt'
co2 = read.table(url, col.names = c("year", "month", "decimal_date",
                                    "monthly_average", "deseasonalized",
                                    "n_days", "st_dev_days",
                                    "monthly_mean_uncertainty"))
head(co2)

## So we got this information from Scripps, and the last three columns are kind 
## of junk data. Taken from over Mauna Loa because there are no anthropogenic 
## changes out in the middle of the Pacific Ocean. 

## I also want to see what type of data this is, so I'm going to check with 
## the class() function, the head() function, and the summary() function.
class(co2) 
summary(co2) 


## Where does our time series start and end? What is the max CO2 level recorded
## at Mauna Loa?

range(co2$decimal_date)
## Starts in 1958 and goes til 2021.

max(co2$monthly_average)
## The max value of CO2 is 417. Woof. 


## Okay, so now I want to plot the monthly average CO2 concentration (in ppm) 
## to examine the Keeling curve. 
plot(monthly_average ~ decimal_date, type="l", data=co2) 


## Well, we want to plot the deseasonalized data, which means, they removed the 
## monthly cycle so we can see the trend over time more easily. We also want 
## to make the plot prettier by creating a title and axis titles.

## Note '+' keeps lines together so RMarkdown doesn't close the plot before all 
## elements are added.
plot(monthly_average ~ decimal_date, type="l", data=co2, ylab="CO2 ppm", xlab="Year", 
     main="Keeling Curve") + 
lines(y=co2$deseasonalized, x=co2$decimal_date, col="red")


## All right, that's a pretty plot, so I want to keep it. 
pdf('figures/keelingCurve.pdf', width=7, height=5)
plot(monthly_average ~ decimal_date, type="l", data=co2, ylab="CO2 ppm", xlab="Year",
     main="Keeling Curve") + 
lines(y=co2$deseasonalized, x=co2$decimal_date, col="red")
dev.off()


## Great. Now let's look closer at the monthly cycle. We can subtract the 
## deseasonalized CO2 to just look at the seasonal variation. 
## We're going to do this by making a new column in our data frame using $.
co2$seasonal_cycle = co2$monthly_average - co2$deseasonalized 

## What does this new data look like? 
head(co2)

plot(seasonal_cycle ~ decimal_date, type="l", data=co2) 


## Okay, I want to look at the most recent 5 years of the seasonal cycle
## so that we can more easily look at it. Here's a refresher on subsetting:

## 2 ways to get the third row of the first column:
co2[1,3]  
## This returned the 3rd row of the 1st column (output is 1958.203)

## This will return the 3rd row of the year column.
co2$year[3]
## This output is 1958.

## 2 ways to get the whole second column (commented out bc it's a lot to print)
## co2[,2]   
## co2$month 

## 2 ways to get the first 6 rows of every column
co2[c(1:6),]   
head(co2)

## Showing 2 ways to subset. This first way will give us a vector of TRUEs and
## FALSEs.
summary(co2$decimal_date > 2015) 
## This way we know that we have 73 data points that are after 2015. 
## This next way gives us a summary of indices that meet the condition.
summary(which(co2$decimal_date > 2015)) 

## Either method can be used to subset the data. We only want values of 
## co2$decimal_date greater than 2015. We can use a conditional statement >
## to signal values greater than 2015. 
co2_2016to2020 = co2[co2$decimal_date > 2015,]


## Now let's plot it.
plot(seasonal_cycle ~ decimal_date, type="l", data=co2_2016to2020) 


## Okay, but it's hard to tell which month is which on this. Let's make a table 
## that shows the average CO2 anomaly for each month over the time series. We can 
## calculate the monthly anomaly for January by subsetting only data where 
## month == 1 and then taking the mean of our seasonal_cycle variable. 

## So I want to grab seasonal_cycle data only from the month of January.
jan_anomalies = co2[which(co2$month==1),'seasonal_cycle'] 
head(jan_anomalies)

## Now let's take the mean of our January data.
mean(jan_anomalies) 
## This can throw us an error because mean() wants to operate on a vector, 
## not a list / data.frame. To make this numeric, we can force the data
## to be numeric by using the unlist() function. 

?unlist

class(jan_anomalies)
class(unlist(jan_anomalies))

## Now we can find the average of the January anomalies, since we've simplified 
## the data to create a vector of the values. 
mean(unlist(jan_anomalies))


## Now I want to calculate the average month anomaly for all 12 months. We should
## make a new data.frame that will hold our results. We want 2 columns: 1 for month 
## and 1 for average anomaly for that month. Then we can calculate monthly average
## anomaly, like we did above, and insert it into the right spot in our data.frame.

## I want to see what the data looks like again to make sure I'm pulling the right
## variables. 
head(co2)

## Now I'm making a new data.frame called co2_monthly_cycle, and adding columns
## for each month using the $ sign. 
co2_monthly_cycle = data.frame(month=c(1:12), detrended_monthly_cycle=NA) 

## Note how it automatically recycles NA to fill the column, because we haven't 
## given that column the data yet.
head(co2_monthly_cycle)

co2_monthly_cycle$detrended_monthly_cycle[1] = mean(unlist(co2[which(co2$month==1),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[2] = mean(unlist(co2[which(co2$month==2),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[3] = mean(unlist(co2[which(co2$month==3),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[4] = mean(unlist(co2[which(co2$month==4),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[5] = mean(unlist(co2[which(co2$month==5),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[6] = mean(unlist(co2[which(co2$month==6),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[7] = mean(unlist(co2[which(co2$month==7),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[8] = mean(unlist(co2[which(co2$month==8),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[9] = mean(unlist(co2[which(co2$month==9),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[10] = mean(unlist(co2[which(co2$month==10),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[11] = mean(unlist(co2[which(co2$month==11),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[12] = mean(unlist(co2[which(co2$month==12),'seasonal_cycle']))

# Examine and plot detrended monthly cycle
co2_monthly_cycle
plot(detrended_monthly_cycle ~ month, type="l", data=co2_monthly_cycle) 


## Well that was ugly and very prone to typing errors. Let's learn a trick to 
## not have to do that again. 

## Exercise 4.1:
## As a result of climate change, there have been many phenological changes in
## the physical and biological environment. That means there is a shift in the 
## timing of seasonal phenomena and activities. One of the most obvious examples
## of this is that as many parts of the world warm, the spring growing season
## for plants is starting a bit earlier each spring. 

## Plot the seasonal cycle of 
## co2 for 1959, the first full year of data, and 2019, the last full year of data
## on the same figure. What do you notice? Is this a robust analysis to determine
## if there has been a phenological shift in global carbon uptake/respiration?

## I want to make another data frame for the seasonal cycle of 1959, and one
## for seasonal cycle of 2019.

co2_1959 = co2[which(co2$decimal_date > 1959 & co2$decimal_date < 1960),]
head(co2_1959)

co2_2019 = co2[which(co2$decimal_date > 2019 & co2$decimal_date < 2020),]
head(co2_2019)

plot(seasonal_cycle ~ month, type="l", data=co2_1959, ylab="Seasonal cycle", 
     xlab="Month", main="Seasonal Cycle CO2 data in 1959 and 2019", 
     ylim=c(max(co2_2019$seasonal_cycle), min(co2_2019$seasonal_cycle)))
lines(y=co2_2019$seasonal_cycle, x=co2_2019$month, col="red")
