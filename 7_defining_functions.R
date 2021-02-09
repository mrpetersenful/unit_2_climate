## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.asp = 0.8, collapse=TRUE) 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
avg = function(x){
  s = sum(x)
  n = length(x)
  s/n
}


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
x = 1:100
avg(x)
mean(x)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
s = 3
avg(1:10)
s


## ---- eval=FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
## my_function = function(VARIABLE_NAME){
##   perform operations on VARIABLE_NAME and calculate VALUE
##   VALUE
## }


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Calculate arithmetic mean by default, or calculate geometric mean if the parameter 'arithmetic' is set to FALSE
avg = function(x, arithmetic = TRUE){
  n = length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
dat = c(1,3,5,7)
avg(dat)
avg(dat, TRUE) # Same answer as above since TRUE is the default
avg(x=dat, arithmetic=TRUE)  # here we make our selection of the default parameter explicit
avg(x=dat, arithmetic=FALSE)  


## ---- eval=FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
## avg()  # didn't include the required parameter x
## avg(FALSE, dat)  # reversed the order of the parameters without explicitly naming the parameters


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Calculate arithmetic mean by default, or calculate geometric mean if the parameter 'arithmetic' is set to FALSE
avg = function(x, arithmetic = TRUE){
  if(!is.numeric(x)) {stop("Error: function failed. x must be a numeric")}
  n = length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}


## ---- eval=FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
## avg(FALSE)


## ---- eval=FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
## # Too short
## f()
## 
## # Not a verb, or descriptive
## my_awesome_function()
## 
## # Long, but clear
## remove_na()
## plot_time_series()

