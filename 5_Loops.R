## ----setup, include=FALSE-------------------------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.asp = 0.618, collapse=TRUE) 


## -------------------------------------------------------------------------------------
for (i in c(1:4)) {
  print("one run")
}


## -------------------------------------------------------------------------------------
for (i in c(1:4)) {
  print(i)
}


## -------------------------------------------------------------------------------------
for (value in c("My", "second", "for", "loop")) {
  print(value)
}


## -------------------------------------------------------------------------------------
value


## -------------------------------------------------------------------------------------
my_vector = c(1,3,5,2,4)
n = length(my_vector)
my_vector_squared = rep(NA,n) # initialize the results vector
for (i in seq(n)) {
  my_vector_squared[i] = my_vector[i]^2
}
my_vector_squared


## -------------------------------------------------------------------------------------
mat = matrix(c(2,0,8,3,5,-4), nrow=2, ncol=3)
mat_squared = matrix(rep(NA,6), nrow=2, ncol=3) # This matrix will hold our results

for(i in c(1:2)){
  for(j in c(1:3)){
    mat_squared[i,j] = mat[i,j]
  }
}



## -------------------------------------------------------------------------------------
for(i in c(1:2)){
  for(j in c(1:3)){
    print(paste("row i=",i," and column j=",j)) 
  }
}


## -------------------------------------------------------------------------------------
my_vector^2
mat^2


## -------------------------------------------------------------------------------------
total_catch_lb = 0  # track the weight of fish I've caught
n_fish = 0   # track the number of fish I've caught
while (total_catch_lb < 50){
  n_fish = n_fish+1  # I caught another fish!
  new_fish_weight = rnorm(n=1, mean=2, sd=1) # randomly generate the weight of a fish
  total_catch_lb = total_catch_lb + new_fish_weight
}

n_fish
total_catch_lb

