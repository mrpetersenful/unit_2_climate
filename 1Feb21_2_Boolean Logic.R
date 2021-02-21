## 1 Feb 2021 
## Lesson 2.2: Boolean logic

## I need to catch up on this damn lesson. Yeesh. 

## To try to keep up in class, I'm going to create these R script files before
## class, with the commands built in previously, so I can try to annotate during 
## class. Fingers crossed this works. 

## Note: In class, Erin showed us how to purl -- which is to pull
## all the code from an .Rmd file and turn it into a .R file.
## Use this command: 
## knitr::purl("3_if_else.Rmd")  -- except replace the file name
## in the purl function. THIS IS GONNA KICK ASS. 


## To begin the lesson, we are working with a vector again. To subset values of 
## TRUEs and FALSEs, the subset has to be the same length as the vector. 

vec = c(1, 0, 2, 1)
vec[c(FALSE, FALSE, TRUE, FALSE)]
## This returns the only true value, which is 2. However, we don't necessarily need
## to create these long lists of TRUEs and FALSEs. We can use logical subsetting
## instead. 

## This question is asking if 1 is greater than 2, and it returns FALSE.
1 > 2

## Now we're asking if 1 is greater than the vector's components, and we get
## TRUE FALSE FALSE as an output. 
1 > c(0, 1, 2)

## Are these vectors' components equal?
c(1, 2, 3) == c(3, 2, 1)
## We receive output of FALSE TRUE FALSE.

## The following is a list of syntax and their meanings:
##   >     a > b       Is a greater than b?
##   >=    a >= b      Is a greater than or equal to b?
##   <     a < b       Is a less than b?
##   <=    a <= b      Is a less than or equal to b?
##   ==    a == b      Is a equal to b?
##   !=    a != b      Is a not equal to b?
##   %in%  a %in% c(a,b,c)   Is a in the group c(a,b,c)?
## Each of these operators returns a TRUE or FALSE. However %in% is the only operator
## that doesn't do normal element-wise execution. If you provide vectors on the left 
## and right side of the vectors, it will not pair up the values. It will test 
## the individual values in the vector on the left to see if they're present in the
## vector on the right. 

1 %in% c(3, 4, 5)
## Returns FALSE.
c(1, 2) %in% c(3, 4, 5)
## Returns FALSE FALSE.
c(1, 2, 3) %in% c(3, 4, 5)
## Returns FALSE FALSE TRUE.
c(1, 2, 3, 4) %in% c(3, 4, 5)
## Returns FALSE FALSE TRUE TRUE.


## You can compare any two R objects with a logical operator, however, logical operators
## make sense if you compare two objects of the same data type. If you compare 
## different data types, R will use its coercion rules to coerce the objects to the 
## same type before it makes the comparison.

## I want to check out some of these functions with our data frame
## from an old lesson. 

world_oceans = data.frame(ocean = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))

## I want to check what our data set looks like: 
head(world_oceans)

## Now I want to subset the oceans with a depth of more than 4000 m. 
world_oceans$avg_depth_m > 4000
## The values returned to us are FALSE TRUE FALSE FALSE TRUE.


## If you sum a set of logical variables (True/False), it will 
## tell you the number of TRUES
sum(world_oceans$avg_depth_m > 4000)
## The output is 2 because 2 oceans meet the true condition. 


## Using the dollar sign points to a specific column, so will give 
## us the response of which oceans have the TRUE response of what
## is specified in the subsetting (the brackets).
world_oceans$ocean[world_oceans$avg_depth_m > 4000]
## The output is Pacific and Southern. Pretty cool. 


## This is subsetting the data, so it actually just gives me all of
## the true variables, instead of just TRUE
world_oceans[world_oceans$avg_depth_m > 4000, ]



## Exercise 2.1: Create vector with names of oceans I've personally 
## visited. Use %in% operator to subset oceans I've visited from 
## world_oceans data frame. Now use subsetting to find out whether I have
## personally visited any oceans that have a smaller area than the 
## Atlantic ocean. 

head(world_oceans)
## I've visited these oceans, so these variables are what I want to check for
## in the data set. 
my_ocean_names = c("Atlantic", "Pacific")

## Now I'm going to name a new variable, my_oceans, and set it equal to the
## oceans that I've actually visited in the dataset of world_oceans.
my_oceans = world_oceans[ world_oceans$ocean %in% my_ocean_names, ]
print(my_oceans)
## Now when I checked the output of my oceans, it gives me all of the variables
## (ocean info) that I visited out of the entire dataset. 
## Now I want to check to see if any of the oceans that I've visited are 
## smaller than the Atlantic.
## First I want to name the Atlantic area variable, so that I can easily use 
## that instead of writing a function to figure that ish out. 
Atlantic_area = world_oceans$area[world_oceans$ocean=='Atlantic']
my_small_oceans = my_oceans[ my_oceans$area_km2 < Atlantic_area]
print(my_small_oceans)
## I returned an output of 0 rows, here, so I've visited 0 oceans that are smaller
## than the Atlantic.

## Precision errors: 1+2=3, but 0.1+0.2=0.3 is false. This is 
## because how numbers are stored in binary. This can be fixed by 
## using an error threshold that is very small. I'm going to use 
## the absolute value, because I don't know if the number is off
## by a positive or negative amount. 

1 + 2 == 3
0.1 + 0.2 == 0.3

0.3 - (0.1 + 0.2)

error_threshold = 0.000001 
abs(0.3 - (0.1 + 0.2)) < error_threshold

## Now to Boolean operators! Yay. | means "or", by the way. 
## R has 6 Boolean operators. They collapse the results of multiple logical 
## tests into a single TRUE or FALSE.

## List of Boolean operators: 
##   %       cond1 & cond2       Are both cond1 and cond2 true?
##   |       cond1 | cond2       Is one or more of cond1 and cond2 true?
##   xor     xor(cond1, cond2)   Is exactly one of cond1 and cond2 true? 
##                    This is a mutually exclusive operator. 
##   !       !cond1              Is cond1 false? (e.g., ! flips the results of a 
##                                  logical test).
##   any     any(cond1,cond2,cond3,...)   Are any of the conditions true?
##   all     all(cond1,cond2,cond3,...)   Are all of the conditions true?





## Okay, now let's play with some conditions: 
x = 10
y = 5
z = 2

x < y & y > z
x < y | y > z





a = c(1, 2, 3)
b = c(1, 2, 3)
c = c(1, 2, 4)
a == b

b == c

a == b & b == c


world_oceans$ocean[world_oceans$avg_depth_m > 4000
                   & world_oceans$area_km2 < 50e6]


z = c(TRUE, TRUE, FALSE)
any(z)

all(z)


## NA does not play nicely with any of the logic questions. 
NA == NA
is.na(NA)

data = c(1, 2, 3, NA) == NA





vec <- c(1, 2, 3, NA)
is.na(vec)



## Exercise 2.2: Here are some random variables. Try converting 
## the sentences into tests written with R code. 
w = 15
x = c(-1, 0, 1)
y = "February"
z = c("Monday", "Tuesday", "January")
## Is w greater than 10 and less than 20?
## Are any of the values in x positive? 
## Are all of the values in x positive?
## Is object y the word February?
## How many values in z are days of the week?

