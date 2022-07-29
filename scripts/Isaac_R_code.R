setwd("C:/Users/Isaac Norden/Desktop/Git Fun/Data")

library('here')
library('tidyverse')

traffic_data <- read.csv(here("data", "Traffic_camera_offences_and_fines.csv"))

#traffic_data[colnames(traffic_data)[0:4]] <- lapply(colnames(traffic_data)[0:4], factor)

traffic_data$Offence_Month = as.factor(traffic_data$Offence_Month)

traffic_data$Rego_State = as.factor(traffic_data$Rego_State)

traffic_data$Clt_Catg= as.factor(traffic_data$Clt_Catg)

traffic_data$Camera_Type = as.factor(traffic_data$Camera_Type)

traffic_data$Offence_Desc = as.factor(traffic_data$Offence_Desc)


plot_df <- traffic_data %>% group_by(Offence_Desc) %>% summarise(sum_withdrawn_ammount = sum(Sum_With_Amt) / sum(Sum_Inf_Count)) %>% 
  arrange(desc(sum_withdrawn_ammount))
plot_df <- plot_df2[is.finite(plot_df2$sum_withdrawn_ammount),]

axis_names = c("School Z. Exceed Lim. > 45 Km/H",
               "20 S.Z. Exceed Lim. Between 30 & 45",
               "Red Arrow at Intersection",
               "Red Light at Intersection",
               "20 School Z. Exceed Lim. > 45 Km/H")
par(mar=c(12, 4.1, 4.1, 2.1))
barplot(plot_df$sum_withdrawn_ammount, las=2, names.arg = axis_names, cex.names = 0.7)
title = "Average Amount Withdrawn for Different Offences"
sub_title = "For offences where more than $0 is withdrawn"
mtext(side=3, line=3, at=-0.07, adj=0, cex=1.6, title)
mtext(side=3, line=2, at=-0.07, adj=0, cex=1, sub_title)
