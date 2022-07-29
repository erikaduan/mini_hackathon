#To generate image, run script in Rstudio, and then run m in the console

library(dplyr)
library(ggplot2)
library(leaflet)

df <- read.csv("data/camera_data.csv")
df <- na.omit(df)

df$average_pen <- df$total_pen / df$total_incidents


#Making the colour palette to colour the data points on the map
qpal <- colorQuantile(
  palette = "Reds",
  domain = df$average_pen,
  n = 9
)
qpal_colors <- unique(qpal(sort(df$average_pen)))
qpal_labs <- round(quantile(df$average_pen, seq(0, 1, 1/9))) # depends on n from pal
qpal_labs <- paste(lag(qpal_labs), qpal_labs, sep = " - ")[-1] # first lag is NA

# Create the map
m <- leaflet(df) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addMarkers(lng=149.120783, lat=-35.308939) %>%
  addCircles(lat = ~lat, 
             lng = ~lon, 
             weight= 0,
             radius = ~13*sqrt(total_incidents),
             color = ~qpal(average_pen),
             fillOpacity=0.8)  %>%
  addLegend("bottomleft", 
            color=qpal_colors, 
            labels=qpal_labs,
            title="Average Penalty",
            labFormat = labelFormat(prefix = "$"))
  
