#To generate image, run script in Rstudio, and then run m in the console

library(dplyr)
library(ggplot2)
library(leaflet)
library(leaflegend)


library(htmlwidgets)




filename <- paste(dirname(getwd()), '/data/camera_data.csv', sep = "")

df <- read.csv(filename)
df <- na.omit(df)
summarise(df)
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
  addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
  setView(149.15, -35.3, zoom=11) %>%
  addCircles(lat = ~lat, 
             lng = ~lon, 
             weight= 0,
             radius = ~0.5*total_incidents,
             color = ~qpal(average_pen),
             fillOpacity=0.8,
             label = ~total_incidents)  %>%
  addLegend("bottomleft", 
            color=qpal_colors, 
            labels=qpal_labs,
            title="Average Penalty",
            labFormat = labelFormat(prefix = "$", digits=2)) %>%
  addLegendSize(
    values = df$total_incidents,
    color = 'red',
    fillOpacity = 0.8,
    title = 'Number of Incidents',
    shape = 'circle',
    breaks = 5,
    baseSize = 4
  )

filename_map <- paste(dirname(getwd()), '/outputs/ACT_traffic_incidents.html', sep = "")
saveWidget(m, file=filename_map)
  
