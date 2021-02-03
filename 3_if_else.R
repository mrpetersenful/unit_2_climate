## 3Feb2021
## Lesson 2.3: Conditional Statements.


## NOTE: Make sure to rename this file when you've started it!



## ----setup, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.asp = 0.618, collapse=TRUE) 



num = -2
if (num < 0) {
  num = num * -1
}
num
## You can have as many "then" statements inside the squiggly brackets
## as you want, including popping a message up (you would use print()).




num = 4
if (num < 0) {
  num = num * -1
}
num
## 4


## --------------------------------------------------------------------
num = -1
if (num < 0) {
  print("Uh-oh! num is negative.")
  num = num * -1
  print("Now num is positive.")
}
num

## Exercise 3.1:
temp = 97
if(temp > 98.6) {
  diff = temp - 98.6
  print(diff)
  if(temp > 101){
    print("Warning! Too Hot.")
  }
}


## Now we're going to do something more fun. 
grade = 83

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


## But what if there's a tie??
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



## --------------------------------------------------------------------
a = 1
b = 1
if (a > b) {
  print("A wins!")
} else if (a < b) {
  print("B wins!")
} else {
  print("Tie.")
}


## We can also make this process simpler, with less coding commands.
## If first condition is true, do this, if false do this. Or, 
## ifelse(condition, if true do this, if false do this).

a = -1
ifelse(a > 0, 1/a, NA)


## --------------------------------------------------------------------
a = c(0, 1, 2, -4, 5)
result = ifelse(a > 0, 1/a, NA)
cbind(a,result)


## --------------------------------------------------------------------
data = c(1,3,5,-999,2,-999,8)

