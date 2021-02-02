## 1 Feb 2021 -- Woof, this class went reeeeeal fast. 

## In this section, we are using NASA GRACE satellite data as a proxy for 
## ice sheet loss in Antarctica and Greenland. 

## Erin already saved the data in this repository, so it should already be 
## in this R project. 

## When I want to open an existing R project, the file type looks like a little 
## cube with an R in it. 

## I want to read in the data. 

read.table('data/antarctica_mass_200204_202008.txt', skip=31,
           col.names=c("decimal_date", "mass_Gt", "sigma_Gt"))
## Now we have the table reading out in our console. We gave it the name of 
## the file, that is in the directory, then told it to skip the first 31 lines 
## (which are a header -- metadata), and then named the column names. 



## However, we want to name the table a variable name. 
ant_ice_loss = read.table('data/antarctica_mass_200204_202008.txt', skip=31,
                          col.names=c("decimal_date", "mass_Gt", "sigma_Gt"))

## Now I'm going to add the Greenland data, naming it grn_ice_loss.
grn_ice_loss = read.table('data/greenland_mass_200204_202008.txt', skip=31, 
                          col.names=c("decimal_date", "mass_Gt", "sigma_Gt"))

## Every time we load in data, the first thing that we want to do is to 
## look at it, to make sure it's correct and in there correctly. One tool 
## to do this is to use the head() function. This gives you the first six 
## lines of the data table. 

head(ant_ice_loss)
head(grn_ice_loss)

## We can also look at the dimensions of the data using the dim() function.
## This is telling us we have 188 rows and 3 columns.

dim(ant_ice_loss)
dim(grn_ice_loss)

## We can also look at the summary of the data using the summary() function. 

summary(ant_ice_loss)
summary(grn_ice_loss)

## If you open up either of the variables in the Environment tab (right hand 
## side of R Studio), you can see the data sets in this window, they'll 
## open up in a new tab. However, in those data sets from the Environment 
## tab, you can manually change that data, and that data will be there 
## FOREVER. So don't change those data points!!

## Now we want to plot the data. There are a couple of ways to do this. 
## x,y -- passing R two parameters, one on the x, one on the y-axis.
## y~x -- this is technically a formula in R (whenever there is a tilda in
## a command, it's a formula.


## I'm going to use formula style with the tilda. I'm going to plot the mass 
## as a function of decimal date to see how ice loss has changed over time.

plot(mass_Gt ~ decimal_date, data = ant_ice_loss)

## So this looks like a pretty good plot. The points are big and the y- and 
## x-axes aren't named correctly.

## If you hit the Zoom button on the Plots screen, the plot will pop out. 

## Now I want to give it a title. 

plot(mass_Gt ~ decimal_date, data = ant_ice_loss, main="Antarctic ice loss", 
     ylab = "Mass loss (Gt)")

## Now I'm going to do this for the Greenland data.

plot(mass_Gt ~ decimal_date, data = grn_ice_loss, main="Greenland ice loss", 
     ylab = "Mass loss (Gt)")

## There is also a gap in the data from 2017 and 2018 when the mission 
## wasn't going. 

## Now I want to see both of these on the same plot. 

## If I use the plot() function, it just creates a new plot. I can then add
## points in with following commands, such as points() or line()

plot(mass_Gt ~ decimal_date, data = ant_ice_loss, 
     ylab = "Mass loss (Gt)")
points(mass_Gt ~ decimal_date, data = grn_ice_loss, 
       ylab = "Mass loss (Gt)")

## I deleted the title from the above, because it wasn't super necessary
## anymore. I'm going to do this again, but now make Greenland data red. 

plot(mass_Gt ~ decimal_date, data = ant_ice_loss, 
     ylab = "Mass loss (Gt)")
points(mass_Gt ~ decimal_date, data = grn_ice_loss, 
       ylab = "Mass loss (Gt)", col="red")

## Okay, but now my Greenland data is off the y-axis, so I'm going to 
## change the y-axis boundary. But I need to know the range of the mass 
## in Gt. I can check that with the range function. I want to just put 
## that limit right into the code for the PLOT, not the code for the 
## points. 
range(grn_ice_loss$mass_Gt)

plot(mass_Gt ~ decimal_date, data = ant_ice_loss, 
     ylab = "Mass loss (Gt)", ylim=range(grn_ice_loss$mass_Gt))
points(mass_Gt ~ decimal_date, data = grn_ice_loss, 
       ylab = "Mass loss (Gt)", col="red")

## I also want to have a line graph. So I'm going to specify line type
## in the plot() function with type="l", and I'm going to use lines() as 
## the specifier for the second type of data to throw in. 

plot(mass_Gt ~ decimal_date, data = ant_ice_loss, 
     ylab = "Mass loss (Gt)", ylim=range(grn_ice_loss$mass_Gt), type = "l")
lines(mass_Gt ~ decimal_date, data = grn_ice_loss, 
       ylab = "Mass loss (Gt)", col="red")

## However, there's a gap in the GRACE mission in 2017-2018. So we want to 
## insert an "NA" in 2017-2018, so that there's no data there, and it 
## doesn't plot in the line. 

## Insert break in the data 2017-2018.

head(ant_ice_loss)
## This is to remind myself of what the data table looks like. 
tail(ant_ice_loss)
## This also shows me the last 6 points of the data.

## Okay, so I'm going to create a new data frame that fits into our 
## ant_ice_loss and grn_ice_loss data frames with our NA data in it. 

data_break = data.frame(decimal_date = 2018, mass_Gt=NA, sigma_Gt=NA)
data_break

## So in those lines of code, which I named data_break, I had to make
## sure that the lines of code matched up to the original data sets. 
## Then I checked that data frame. Now I want to append this data frame
## to the end of the ant_ice_loss data. 

ant_ice_loss_with_NA = rbind(ant_ice_loss, data_break)
tail(ant_ice_loss_with_NA)

## Now, I've renamed our data set ant_ice_loss to be very specific, so 
## that it has the data break in it, then I checked the tail of the 
## data. The tail now has the 2018 point in it. 
