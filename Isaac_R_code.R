setwd("C:/Users/Isaac Norden/Desktop/Git Fun/Data")

traffic_data <- read.csv("Traffic_camera_offences_and_fines.csv")


#traffic_data[colnames(traffic_data)[0:4]] <- lapply(colnames(traffic_data)[0:4], factor)

traffic_data$Offence_Month = as.factor(traffic_data$Offence_Month)

traffic_data$Rego_State = as.factor(traffic_data$Rego_State)

traffic_data$Clt_Catg= as.factor(traffic_data$Clt_Catg)

traffic_data$Camera_Type = as.factor(traffic_data$Camera_Type)

traffic_data$Offence_Desc = as.factor(traffic_data$Offence_Desc)


barplot(prop.table(table(traffic_data$Offence_Desc)), las=2)
barplot(table(traffic_data$Offence_Desc), las=2)


