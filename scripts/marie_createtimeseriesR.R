library(here)

data<- read.csv("../data/Traffic_camera_offences_and_fines.csv")
# visualise data

install.packages("stringr")
install.packages("car")
install.packages("ggplot2")
install.packages("readr")
install.packages("dplyr")
install.packages("tseries")
library(ggplot2)
library(readr)
library(car)
library(zoo)
library(stringr)
library(dplyr)
library(tseries)

# convert offence month into date to create time series
# first, create numeric month

data$date<- gsub("Jan ", "01-01-",
                  gsub("Feb ", "01-02-",
                  gsub("Mar ", "01-03-",
                  gsub("Apr ", "01-04-", 
                  gsub("May ", "01-05-",
                  gsub("Jun ", "01-06-", 
                  gsub("Jul ", "01-07-", 
                  gsub("Aug ", "01-08-", 
                  gsub("Sep ", "01-09-",
                  gsub("Oct ", "01-10-",
                  gsub("Nov ", "01-11-", 
                  gsub("Dec ", "01-12-", data$Offence_Month))))))))))))

#then use date function to convert into date                       
data<- replace(data, is.na(data), 0)
data$date<- as.Date(data$date, format = "%d-%m-%Y")

#create data frame with sum of penalties for dates
newdat<-data.frame(data$date, data$Sum_Pen_Amt)
newdat2<-aggregate(newdat["data.Sum_Pen_Amt"], by=newdat["data.date"], sum)
colnames(newdat2)<- c("date", "SumPenalties")

#create time series
penaltiests<-ts(newdat2$SumPenalties, start= 2010, frequency = 12)
plot(penaltiests)

#decompose time series to assess components
decomp<-decompose(penaltiests)
plot(decomp)

# difference time series
diff.penaltiests<- diff(penaltiests)
plot(diff.penaltiests)





