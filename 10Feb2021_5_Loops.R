## 10 Feb 2021
## 2.5: For loops

## Often in data science and programming, tasks or code chunks need to be repeated
## many times, or a small change needs to be made during each repetition. 
## We can use loops to achieve this. 

## A for loop repeats a chunk of code many times, once for each element in a set 
## of input. For loops tell R "Do this for every value of that." In R syntax, 
## this looks like:
##    for (value in that){
##      this
##      }

## The that object should be a set of objects (often a vector of numbers or character
## strings). The for loop will run the code that appears between the braces once 
## for each member of that. 

## This for loop runs print("one run") once for each element in the vector c(1,2,3,4):
for (i in c(1:4)) {
  print("one run")
}
## Our output is "one run" repeated four times, once for each element in the 
## specified vector. Each time the for loop ran is called an iteration. This loop ran 
## 4 times, because the iterand named i stepped through a vector with 4 elements. 
## The code in your loop can access this value by calling the i object. 


## In this for loop, the iterand i will print in each iteration.
for (i in c(1:4)) {
  print(i)
}
## Our output was 1 2 3 4 because i was printed for each iteration.

## A for loop starts with the first element and then assigns a different element to the
## iterand i on each run of the for loop, until all of the elements have been 
## assigned to i. The iterand can have any name, and the loop can step through
## any type of vector. 

## This for loop will run print(value) four times, and will print out one element of
## the vector c("My", "second", "for", "loop") each time. 
for (value in c("My", "second", "for", "loop")) {
  print(value)
}


## The last iteration will be saved, so if we evaluate "value", it will output "loop"
## because that's the last thing that we assigned to "value".
value


## The most common usage of a for loop is to create some iterand (often named i) that
## will step through each element in a vector and act on the elements of that vector
## in some way with the iterand acting as an index inside the loop. This can work 
## for doing some mathematical calculation or applying some function to each element
## in a vector and saving it in a new vector. 

## For example, I want to know the square of each value in my data, so I'm going to
## use a for loop in the following way:

my_vector = c(1,3,5,2,4)
n = length(my_vector)
## Now initialize the results vector.
my_vector_squared = rep(NA,n) 
for (i in seq(n)) {
  my_vector_squared[i] = my_vector[i]^2
}
my_vector_squared

?length

## Something that is important to note is that an empty vector with the correct
## length was made before starting the for loop and the iterand i was used to step
## through both our original data vector and our new results vector. 
## Programmers call this initializing an aboject, or creating an empty object 
## to fill later. This is much better (and faster) than appending a new result onto
## a results vector, and therefore changing the length of the results vector with 
## every iteration of the loop. 

?rep
## So the rep function replicates the values in x, which we named later, by repeating
## n times. The values in my_vector_squared were then filled in in the chunk of 
## code after the for command (and after the iterand).


## Exercise 5.1: 
## Use a for() loop to calculate the factorial (!) of any integer number greater
## than 0. (For example: 3! = 3*2*1 = 6). Test with num = 3 and num = 6.

num = 6
factorial = 1
for (i in seq(num)){
  factorial = i*factorial
}
factorial

?seq
## Okay, so in this for loop, I wanted to create the factorial, so for every 
## iterand i, I wanted it to multiply 


## Now, I have a 2-D matrix and I want to perform an operation on every element. 
## For example, I have a matrix of numbers with 2 rows and 3 columns, and I want
## to create a second matrix that contains the squared value of each element. 
## I can use a nested for loop, where the first (outer) loop steps through every
## row in the matrix and the second (inner) loop steps through every column of 
## the matrix. Using nested loops, I can systematically interact with each element
## in the matrix one at a time. 

mat = matrix(c(2,0,8,3,5,-4), nrow=2, ncol=3)
mat
## Now I want to initialize the matrix that will hold our results.
mat_squared = matrix(rep(NA,6), nrow=2, ncol=3) 


for(i in c(1:2)){
  for(j in c(1:3)){
    mat_squared[i,j] = mat[i,j]^2
  }
}
mat_squared

## Well, I don't understand what the hell is going on with this loop, so I'm going
## to figure out what the order of operations is in this. This chunk of code will 
## tell me how the nested for loops step through the calculations and fill in the 
## initialized matrix for the results. 
for(i in c(1:2)){
  for(j in c(1:3)){
    print(paste("row i=",i," and column j=",j)) 
  }
}
## [1] "row i= 1  and column j= 1"
## [1] "row i= 1  and column j= 2"
## [1] "row i= 1  and column j= 3"
## [1] "row i= 2  and column j= 1"
## [1] "row i= 2  and column j= 2"
## [1] "row i= 2  and column j= 3"


## As a note, the function paste() joins several strings into one longer string. 
## Programmers call this concatennation. 
## Looking at the output of the paste function above, we can see that first the
## outer loop holds i at a value of 1 while the inner loop steps the iterand j 
## through values of 1, 2, and 3. Then the outer loop holds i at a value of 2 
## while the inner loop steps the iterand j through values of 1, 2, and 3. This
## is how all of the elements are accessed one-by-one in our 2-row, 3-column matrix. 


## Note: Many functions and calculations in R are vectorized, meaning that they are
## written so they'll act independently on each element of the vector so that we
## don't have to go through a for loop. We can just square our vectors and matrices 
## using the following commands. 
my_vector^2
mat^2


## Sometimes, though, a loop may be needed for certain things. For example, making 
## and saving the same type of figure but with many different sets of data. 
## I can make a for loop to step through a range of data sets, then build and save
## the figure inside the loop. 


## Another type of loop is the while loop, which reruns a chunk of code while a 
## certain condition remains TRUE. To create a while loop, follow while by a condition 
## and a chunk of code, like the following: 

##  while (condition) {
##       code
##  }

## While will rerun condition, which should be a logical test, at the start of each
## loop. If condition evaluates to TRUE, while will run the code between its braces. 
## If condition evaluates to FALSE, while will finish the loop. 

## Why would the condition change from TRUE to FALSE? Presumably because the code 
## inside your loop has changed whether the condition is still TRUE. If the code
## has no relationship to the condition, a while loop will run until you stop it. 
## SO BE CAREFUL. You can stop a while loop by hitting Escape or by clicking on the 
## stop-sign icon at the top of the RStudio console pane. The icon will appear once
## the loop begins to run. 

## You can use while loops to do things that take a varying number of iterations. In
## this example, we're going fishing on a lake where there is a 50-lb catch limit.
## We won't know how many fish we can bring home until we've caught and weighed
## each fish that we land. To simulate landing a new fish with each iteration of our
## loop, I'll use a random number generator to supply the weight of the fish. The 
## function rnorm() generates a random number with a normal distribution given the
## mean and sd that is supplied in the parameters. 

## So first, I want to use an element to track the weight of the fish I've caught.
total_catch_lb = 0  
## Then I want to track the number of fish I've caught. 
n_fish = 0  
## Now I'm going to set up my while loop. My logical condition is that while I have
## less than 50lbs of total fish lbs, I can catch more fish.
while(total_catch_lb < 50){
  n_fish = n_fish + 1
  new_fish_weight = rnorm(n=1, mean=2, sd=1)
  total_catch_lb = new_fish_weight + total_catch_lb
}

?rnorm

n_fish
total_catch_lb
print(n_fish)
print(total_catch_lb)