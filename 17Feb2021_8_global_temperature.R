## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.asp = 0.8, collapse=TRUE) 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# temp_anomaly = read.table("data/temp_anomaly_global_mean.txt", skip=5, sep="", header = FALSE)
url = 'https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt'
temp_anomaly = read.delim(url, skip=5, sep="", header=FALSE, col.names = c("Year", "No_Smoothing", "Lowess_5"))
class(temp_anomaly)
head(temp_anomaly)
dim(temp_anomaly)
summary(temp_anomaly)

plot(No_Smoothing ~ Year, data=temp_anomaly, ylab="Global mean temperature anomaly") + # type="b")
  lines(No_Smoothing ~ Year, data=temp_anomaly) +
  lines(Lowess_5 ~ Year, data=temp_anomaly, col="red") 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
plot(No_Smoothing ~ Year, data=temp_anomaly, ylab="Global mean temperature anomaly") + 
  lines(No_Smoothing ~ Year, data=temp_anomaly) +
  lines(Lowess_5 ~ Year, data=temp_anomaly, col="red") +
  abline(v=1998, lty="dashed") +
  abline(v=2012, lty="dashed") # 2012 would be the "current state" when writing the 2013 IPCC report


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
temp_1998 = temp_anomaly$No_Smoothing[which(temp_anomaly$Year==1998)]
temp_2012 = temp_anomaly$No_Smoothing[which(temp_anomaly$Year==2012)]

plot(No_Smoothing ~ Year, data=temp_anomaly, ylab="Global mean temperature anomaly") + 
  lines(No_Smoothing ~ Year, data=temp_anomaly) +
  lines(Lowess_5 ~ Year, data=temp_anomaly, col="red") +
  abline(v=1998, lty="dashed") +
  abline(v=2012, lty="dashed") +
  lines(c(temp_1998, temp_2012)~c(1998, 2012), col="blue", lwd=2) # used the lwd parameter to thicken the line. See ?par


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
dim(temp_anomaly)
seq(dim(temp_anomaly)[1])  # Note c(1:dim(temp_anomaly)[1]) produces same vector

# Initialize my results data frame
roll_avg = temp_anomaly
roll_avg$year5 = NA
roll_avg$year10 = NA
roll_avg$year20 = NA
# Use for loop to calculate 5, 10 and 20 year rolling averages
for (i in seq(dim(temp_anomaly)[1]))
{
  # Calculate 5 year moving averages
  if (i > 2 & i < (dim(temp_anomaly)[1]-2)){
    roll_avg$year5[i] = mean(roll_avg[c((i-2):(i+2)),'No_Smoothing'])
  }
  # Calculate 10 year moving averages
  if (i > 5 & i < (dim(temp_anomaly)[1]-4)){
    roll_avg$year10[i] = mean(roll_avg[c((i-5):(i+4)),'No_Smoothing'])
  }
  # Calculate 20 year moving averages
  if (i > 10 & i < (dim(temp_anomaly)[1]-9)){
    roll_avg$year20[i] = mean(roll_avg[c((i-10):(i+9)),'No_Smoothing'])
  }
}

head(roll_avg)

plot(No_Smoothing ~ Year, data=roll_avg, ylab="Global mean temperature anomaly") + 
  lines(No_Smoothing ~ Year, data=roll_avg) +
  lines(year5 ~ Year, data=roll_avg, col="red") +
  lines(year10 ~ Year, data=roll_avg, col="purple") +
  lines(year20 ~ Year, data=roll_avg, col="blue") 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
pdf('figures/global_mean_temp.pdf', width=7, height=5)
plot(No_Smoothing ~ Year, data=roll_avg, ylab="Global mean temperature anomaly") + 
  lines(No_Smoothing ~ Year, data=roll_avg) +
  lines(year5 ~ Year, data=roll_avg, col="red") +
  lines(year10 ~ Year, data=roll_avg, col="purple") +
  lines(year20 ~ Year, data=roll_avg, col="blue") 
dev.off()

