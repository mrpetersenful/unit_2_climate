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



