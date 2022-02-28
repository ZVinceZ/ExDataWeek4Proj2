library(ggplot2)

#Reads files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge data of both data sets (it takes the SCC# as the commonality)
merged <- merge(NEI, SCC, all = TRUE)

#Creates Subset of Baltimore City data (fips == "24510")
x0 <- subset(merged, fips == "24510")

#Creates Subset of the data related to Motor Vehicles
x1 <- subset(x0, 
             EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | 
               EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
               EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" |
               EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")

#Plots graph with regression line to show trend and reduces ylim to better 
#show trend
g<-ggplot(x1, aes(year, Emissions))+
  geom_point(color = "steelblue", size = 4, alpha = 1/5)+
  geom_smooth(method = "lm", col = "red")+
  coord_cartesian(ylim = c(0, 15))+
  labs(title = "Annual PM2.5 Emissions from Motor Vehicles in Baltimore City", 
       y = "PM2.5 Emmisions [ton]", x = "Year")

#Creates png file
png(filename = "Plot5.png")
print(g)
dev.off() #Closes device