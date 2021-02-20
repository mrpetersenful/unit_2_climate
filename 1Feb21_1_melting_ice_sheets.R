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

## When you rbind() two data sets, make sure that the names of the columns
## of both data sets are exactly the same. 

## Now, I've renamed our data set ant_ice_loss to be very specific, so 
## that it has the data break in it, then I checked the tail of the 
## data. The tail now has the 2018 point in it. 

## Now I want to sort the data so that the dates are in the correct 
## order, otherwise the line would go in a really weird direction, 
## back to 2018 after the 2020 data. 

## Sorting the data with NA
order(ant_ice_loss_with_NA$decimal_date)
## So this gave us back the index and the order of the data that we're 
## sorting. We can see that the 189th term here is now between the 163rd
## and 164th terms. 

## Now I want to take the new ordered set and put it inside the OG 
## data set ant_ice_loss_with_NA. So I'm going to rename this variable, 
## but ordered now, with the following function. Notice that I'm reordering
## with the bracket function, which means I am accessing the elements that 
## are specified. In this case, I want to reorder this data set with the
## order function of a single column (which is decimal date). So the 
## first space in the order() function is by rows, and I want to reorder 
## the rows so that the decimal date is in order, with all columns, so I 
## leave the second command blank, by using a single comma then blank space, 
## then closing the bracket. 

ant_ice_loss_with_NA = ant_ice_loss_with_NA[order(ant_ice_loss_with_NA
                                                  $decimal_date), ]
## Now I want to look at the tail again to make sure that the 2018 data 
## isn't at the end. So I can look at the Environment tab and that data 
## frame to see if it's right. 

tail(ant_ice_loss_with_NA)


## Now I want to do the same thing with the Greenland data. 

grn_ice_loss_with_NA = rbind(grn_ice_loss, data_break)
tail(grn_ice_loss_with_NA)

## Once again, the 2018 data point is at the end of the function, so I'm going
## to reorder and rename it again. 

grn_ice_loss_with_NA = grn_ice_loss_with_NA[order(grn_ice_loss_with_NA
                                                  $decimal_date), ]
tail(grn_ice_loss_with_NA)

## Cool. I checked that the 2018 data is in the right place with the 
## Environmental tab and the tail() function. We lookin good, folx!


## Now I'm going to replot my data using copy-paste for the plot lines, 
## and I'm going to make sure I now have the data frames _with_NA instead
## of the original data frames. 

plot(mass_Gt ~ decimal_date, data = ant_ice_loss_with_NA, 
     ylab = "Mass loss (Gt)", ylim=range(grn_ice_loss_with_NA$mass_Gt), 
     type = "l")
lines(mass_Gt ~ decimal_date, data = grn_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", col="red")

## Okay, so when I try to put the ylim on the grn_ice_loss_with_NA, there 
## technically is no range there because NA is not part of the range, so
## I have to keep the OG grn_ice_loss range in there, or it won't plot. 

plot(mass_Gt ~ decimal_date, data = ant_ice_loss_with_NA, 
     ylab = "Mass loss (Gt)", ylim=range(grn_ice_loss$mass_Gt), 
     type = "l")
lines(mass_Gt ~ decimal_date, data = grn_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", col="red")

## Now I want to plot with the uncertainties. 

plot(mass_Gt ~ decimal_date, data = ant_ice_loss_with_NA, 
     ylab = "Mass loss (Gt)", ylim=range(grn_ice_loss$mass_Gt), 
     type = "l")
## Adding uncertainty to Antarctica, and making that a dashed line instead
## of a solid. To plot uncertainties, I'm making these lines from this plot,
## but changing the line plot y-variable to the (mass_Gt + sigma_Gt column). 
## I am also adding lty = "dashed" to the list of specifications to make it 
## a dashed line. I'm also plotting two std devs, so I'm going to add in 
## that extra factor in my line of code. 
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", lty="dashed")
## So by running this plot() and lines() code, I just get the uncertainty
## above the line. So I need to add the lower uncertainty too. I'm going to 
## copy-paste that line of code with a minus sign to get the lower bound. 
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", lty="dashed")

## Okay, so I'm going to do Greenland now. 

lines(mass_Gt ~ decimal_date, data = grn_ice_loss_with_NA, 
     ylab = "Mass loss (Gt)", col="red")
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = grn_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", lty="dashed", col="red")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = grn_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", lty="dashed", col="red")

## Sweet, we totes nailed it here. Now I'm going to save it. 
## I want to save it just in case I want it for another table. 
## I'm going to save it by opening up a plot space, and saving the lines
## around it. 

## Save the plot to .PDF to the figures folder that is already there
## in the repository that I downloaded for this R project. So I tell it 
## which form to save to: pdf(), and then in the parentheses, I tell it 
## where to save, which is in that figures folder. Then I name it. The
## width I am specifying as 7 inches (which is the default), and the 
## height will be 5 inches. 

## I have to tell R where to start saving for the PDF file, and tell it 
## where to turn off. So I use the pdf() function to turn on, and dev.off()
## to turn off. 

pdf('figures/ice_mass_trends_MRP.pdf', width=7, height=5)

plot(mass_Gt ~ decimal_date, data = ant_ice_loss_with_NA, 
     ylab = "Mass loss (Gt)", ylim=range(grn_ice_loss$mass_Gt), 
     type = "l")
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", lty="dashed")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", lty="dashed")

lines(mass_Gt ~ decimal_date, data = grn_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", col="red")
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = grn_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", lty="dashed", col="red")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = grn_ice_loss_with_NA, 
      ylab = "Mass loss (Gt)", lty="dashed", col="red")

dev.off()

## I also added my initials so that I can use this as my own plotting 
## work. Woohooooooooooo. It should now be in that file tho. And it is. 


## Stopping work at 48:30 on the BB lecture. Note to self: Check out 
## what the hell the $ command is. 

## No longer have access to recordings. Hopefully that will be fixed. 

## Now I'm going to make a bar plot showing the ice loss diff btwn Greenland
## and Antarctica. 

## Largest observed decrease in ice mass loss in Antarctica-- this is how we
## find the minimum (or the max of lost ice)

min(ant_ice_loss$mass_Gt)

## Let's make a barplot now. 

barplot(height=c(min(ant_ice_loss$mass_Gt), min(grn_ice_loss$mass_Gt)))

## Okay, that's nice, but I want to flip it to positive, add x-axis labels, and 
## make the y-axis make sense (along with title).

barplot(height=c(min(ant_ice_loss$mass_Gt)*(-1), min(grn_ice_loss$mass_Gt)*(-1)), 
        names.arg=c("Antarctica", "Greenland"), ylim=c(0,5000), ylab="Ice loss in Gt")
        
## Beautiful. 

## Exercise 1.2. 
## Calculate average annual ice loss for each ice sheet by dividing the change in
## ice lost from the beginning to the end of the time series by the total time that
## passed. Then display ice loss rates in bar graph. Save into figures/ 
## directory in this repo. 

## First I want to calculate the ice loss rate (Gt/year) for Antarctica. But I want 
## tofind the last row in the dataset.

dim(ant_ice_loss)
## This command gave me the dimensions. 188 rows, 3 columns. 

dim(ant_ice_loss)[1]
## This command gave me the number of rows. 
dim(ant_ice_loss)[2]
## This command gave me the number of columns. 

## Now I want to find the last row in the dataset and name it. 
n_rows_ant = dim(ant_ice_loss)[1]
## That just named the last row as n_rows_ant.
## Now I'm going to find the change in the mass, then the change in years.
delta_ice_ant = ant_ice_loss$mass_Gt[n_rows_ant] - ant_ice_loss$mass_Gt[1]
delta_date_ant = ant_ice_loss$decimal_date[n_rows_ant] - ant_ice_loss$decimal_date[1]

## Now I can calculate the rate by dividing loss of mass by change in years (multiply
## by -1 because we want it to be a positive lookin thing).

ant_loss_rate_Gt_per_yr = -1 * delta_ice_ant/delta_date_ant
print(ant_loss_rate_Gt_per_yr)

## Now do it with Greenland data.

