library(dplyr)
library(ggplot2)

df <- read.csv("Traffic_camera_offences_and_fines.csv")
codes <- read.csv("Traffic_Camera_Locations.csv")


df <- filter(df, Sum_Pen_Amt <= 50000)

p <- ggplot(data = df, aes(x=Sum_Pen_Amt)) +
  geom_histogram(binwidth = 5) +
  scale_x_log10()