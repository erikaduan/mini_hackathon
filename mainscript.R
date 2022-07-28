library(dplyr)
library(ggplot2)

df <- read.csv("Traffic_camera_offences_and_fines.csv")


df <- filter(df, Sum_Pen_Amt <= 50000)

p <- ggplot(data = df, aes(x=Sum_Pen_Amt)) +
  geom_hist() +
  scale_x_log10()