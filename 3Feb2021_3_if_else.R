## 3Feb2021
## Lesson 2.3: Conditional Statements.


## NOTE: Make sure to rename this file when you've started it!


## "If" statements in R. An "if" statement tells R to do something if you
## get a TRUE return on a condition. It looks like this: 
##   if(this) {
##    that
##  }

## This should be a logical test or an R expression that evaluates to 
## TRUE or FALSE. If "this" is TRUE, then R will run all of the code that
## is in between the brackets following the if statement. If it is FALSE
## then R will skip the code between the brackets without running it. 

## In this case, I want to make sure that some number "num" is positive. 
## If it is less than 0, I want to change it to make it negative. 
num = -2
if (num < 0) {
  num = num * -1
}
num
## This gave me an output of positive 2. If, however, num is positive, 
## then R won't run the code. 
num = 4
if(num < 0) {
  num = num * -1
}
num


## You can have as many "then" statements inside the squiggly brackets
## as you want, including popping a message up (you would use print()).


## Again, the if statement must evaluate to a single TRUE or FALSE. If 
## you get a vector that is a string of TRUEs and FALSEs, the if statement
## will only evaluate the first element. However, you can use the any and all
## statements to make things return as a single TRUE or FALSE.

## You can also have more than a single line of code in your if statement. 
## R will run each line of code in between the brackets. See the following 
## chunk of code. 

num = -1
if (num < 0) {
  print("Uh-oh! num is negative.")
  num = num * -1
  print("Now num is positive.")
}
num



## Exercise 3.1: 
## You've taken someone's temperature and you want to see if
## they have a fever. If they do, see how different their temp is from 
## the normal temp of 98.6, and print out answer. If they DO have a fever,
## then see if the fever is >101, and if it is, then print out a warning 
## message. This requires nested if statements. Test your code with low temp,
## low fever, and high fever.
temp = 94
if(temp > 98.6) {
  diff = temp - 98.6
  print(diff)
  if(temp > 101){
    print("Warning! Too Hot.")
  }
}
## This chunk of code didn't print anything because the temp is not a fever.

temp = 99.4
if(temp > 98.6) {
  diff = temp - 98.6
  print(diff)
  if(temp > 101){
    print("Warning! Too Hot.")
  }
}
## This chunk of code printed the difference between 98.6 and the temp, 0.8.

temp = 102
if(temp > 98.6) {
  diff = temp - 98.6
  print(diff)
  if(temp > 101){
    print("Warning! Too Hot.")
  }
}
## This chunk of code printed the difference between 98.6 and "Warning! Too
## Hot." 

## Now we're going to do something more fun. We're going to learn about else 
## statements. If statements tell R what to do when shit is TRUE, but we can
## also tell R what to do when the statement is FALSE. See the following: 

## if(this) {
## Plan A
## } else {
## Plan B
## }

## When "this" evaluates to TRUE, R will run the code in the first set of 
## braces (Plan A), but when "this" evaluates to FALSE, R will run the code
## in the second set of braces (Plan B), but not the first set. 

## Let's use this to notify a student whether they are passing or failing a 
## class. 

grade = 83
if(grade > 60){
  print("You passed!")
}else{
  print("You failed...")
}

grade = 48
if(grade > 60){
  print("You passed!")
}else{
  print("You failed...")
}


## Now I want to compare a couple of scores. 
score_1 = 35
score_2 = 41
if (score_1 > score_2){
  print("1 wins!")
} else {
  print("2 wins!")
}


## But what if there's a tie?? We can string together a series
## of more than two mutually exclusive events by telling R what
## to do if the first and second conditions are FALSE, such as
## in the case of a tie. 
score_1 = 35
score_2 = 41
if (score_1 > score_2){
  print("1 wins!")
} else if (score_2 > score_1) {
  print("2 wins!")
} else {
  print("they tied")
}

score_1 = 35
score_2 = 35
if (score_1 > score_2){
  print("1 wins!")
} else if (score_2 > score_1) {
  print("2 wins!")
} else {
  print("they tied")
}



a = 1
b = 1
if (a > b) {
  print("A wins!")
} else if (a < b) {
  print("B wins!")
} else {
  print("Tie.")
}

## Exercise 3.2: 
## I have a variable n_donuts, which is how many donuts Pops bought on 
## Sunday. Write an if/else chain to print out a statement that states 
## whether Dad bought less than a dozen, a dozen (12), a baker's dozen
## (13), or more than a baker's dozen.
n_donuts = 15
if(n_donuts < 12){
  print("Dad bought less than 12 donuts! WTF")
} else if (n_donuts == 12){
  print("Dad bought 12 donuts, I guess.")
} else if (n_donuts == 13){
  print("Dad bought a baker's dozen, yee!")
} else {
  print("Dad bought a buttload of donuts, yee!")
}


## We can also make this process simpler, with less coding commands.
## If first condition is true, do this, if false do this. Or, 
## ifelse(condition, if true do this, if false do this). In other words,
## ifelse(logical, true, false).

a = -1
ifelse(a > 0, 1/a, NA)
## Because the logical a > 0 is false, it returns NA, the third argument.


## This argument is nice because it works on vectors. In this case, I'm 
## going to name two vectors. The first is my dataset. The second, I'm 
## going to name result. I'm then going to bind them together so that I 
## can nicely read the results using the command cbind().

a = c(0, 1, 2, -4, 5)
result = ifelse(a > 0, 1/a, NA)
cbind(a,result)
## This returns my output as a matrix with a in the first column and result
## in the second column. That's one neat trick.


## Exercise 3.3:
## In a dataset that I'm using, the number -999 is used to indicate a missing
## value (which is really common). I want to use R's handling of missing values 
## (in math equations, plotting, etc.) to replace those elements with NA. Use 
## the ifelse() statement to replace all of the -999 values in the data vector
## with NA. Then use an if/else chain to print out a statement about whether 
## there are any NAs in the data variable. Might have to use functions like 
## any() and is.na().
data = c(1,3,5,-999,2,-999,8)

## First, I want to rename my dataset that includes NAs. The first condition is 
## my logical condition, "If the number is -999, then make it NA; if not, then 
## leave it as the element in data".
data_with_nas = ifelse(data == -999, NA, data)
data_with_nas
## Now I want to make an if/else statement.
if(any(is.na(data_with_nas))){
  print("There are NAs in this data!")
}else{
  print("There are no NAs in this data.")
}



