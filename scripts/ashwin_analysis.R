
# Packages
install.packages("tidyverse")
library(dplyr)
library(ggplot2)
library(lubridate)

# Setting Working Directory
setwd("C:/Users/Ashwin Rajkumar/Desktop/git_project/repository_name")

# Importing Dataset
data <- read.csv("~/Git/Traffic_camera_offences_and_fines.csv")
View(data)
dim(data)

# Initial Analysis
unique(data$Offence_Month)
unique(data$Rego_State)
unique(data$Clt_Catg)
unique(data$Camera_Type)
unique(data$Offence_Desc)

# Further Analysis
data <- dplyr::filter(data, grepl('NSW|VIC|QLD|SA|WA|TAS|NT|ACT', Rego_State))
               
ggplot(data) +
  geom_bar(aes(x=Rego_State, fill = Rego_State))

ggplot(data) +
  geom_bar(aes(x=Camera_Type, fill = Camera_Type))


ggplot(data) +
  geom_boxplot(aes(y=Sum_Pen_Amt)) +
  scale_y_continuous(limits = c(0, 20000))

summary(data$Sum_Pen_Amt)
first_column <- c("Minimum", "1st Quartile", "Median", "Mean", "3rd Quartile", "Maximum")
second_column <- c(0, 292, 708, 2570, 1895, 1766569)
fines_summary <- data.frame(first_column, second_column)
fines_summary

ggplot(data) +
  geom_boxplot(aes(x= Rego_State, y=Sum_Pen_Amt, fill = Rego_State)) +
  scale_y_continuous(limits = c(0,20000))

ggplot(data) +
  geom_boxplot(aes(x= Camera_Type, y=Sum_Pen_Amt, fill = Camera_Type)) +
  scale_y_continuous(limits = c(0,20000))

data <- mutate(data, Year = year(mdy(data$Offence_Month)))
data$Year <- as.character(data$Year)

ggplot(data) +
  geom_boxplot(aes(x= Year, y=Sum_Pen_Amt, fill = Year)) +
  scale_y_continuous(limits = c(0,5000))
  