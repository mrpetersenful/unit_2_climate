## 1 Feb 2021 
## Lesson 2.2: Boolean logic

## I need to catch up on this damn lesson. Yeesh. 

## To try to keep up in class, I'm going to create these R script files before
## class, with the commands built in previously, so I can try to annotate during 
## class. Fingers crossed this works. 


vec = c(1, 0, 2, 1)
vec[c(FALSE, FALSE, TRUE, FALSE)]


1 > 2
1 > c(0, 1, 2)
c(1, 2, 3) == c(3, 2, 1)



1 %in% c(3, 4, 5)
c(1, 2) %in% c(3, 4, 5)
c(1, 2, 3) %in% c(3, 4, 5)
c(1, 2, 3, 4) %in% c(3, 4, 5)




world_oceans = data.frame(ocean = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
world_oceans$avg_depth_m > 4000


sum(world_oceans$avg_depth_m > 4000)



world_oceans$ocean[world_oceans$avg_depth_m > 4000]


world_oceans[world_oceans$avg_depth_m > 4000, ]



## Exercise 2.1: Create vector with names of oceans I've personally 
## visited. Use %in% operator to subset oceans I've visited from 
## world_oceans data frame. No use subsetting to find out whether I have
## personally visited any oceans that have a smaller area than the 
## Atlantic ocean. 




1 + 2 == 3


0.1 + 0.2 == 0.3


0.3 - (0.1 + 0.2)


error_threshold = 0.000001 
abs(0.3 - (0.1 + 0.2)) < error_threshold



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


NA == NA


c(1, 2, 3, NA) == NA


is.na(NA)


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

