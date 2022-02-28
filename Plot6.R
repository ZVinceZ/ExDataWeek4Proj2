library(ggplot2)

#Reads files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge data of both data sets (it takes the SCC# as the commonality)
merged <- merge(NEI, SCC, all = TRUE)

#Creates Subset of Baltimore City and Los Angeles
x0 <- subset(merged, fips == "24510" | fips == "06037")

#Renames the fips# to the appropriate City name
x0["fips"][x0["fips"] == "24510"] <- "Baltimore City"
x0["fips"][x0["fips"] == "06037"] <- "Los Angeles"

#Creates Subset of the data related to Motor Vehicles
x1 <- subset(x0, 
             EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | 
               EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
               EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" |
               EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")

#Plots graph with regression line to show trend and reduces ylim to better 
#show trend
g<-ggplot(x1, aes(year, Emissions))+
  geom_point(color = "steelblue", size = 4, alpha = 1/10)+
  facet_grid(.~fips)+coord_cartesian(ylim = c(0, 50))+
  geom_smooth(method = "lm", col = "red")+
  labs(title = "Annual PM2.5 Emissions from Motor Vehicles", 
       y = "PM2.5 Emmisions [ton]", x = "Year")

#Creates png file
png(filename = "Plot6.png")
print(g)
dev.off() #Closes device
