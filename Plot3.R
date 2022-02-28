library(ggplot2)

#Reads files
NEI <- readRDS("summarySCC_PM25.rds")

#Creates Subset of Baltimore City data (fips == "24510")
x0 <- subset(NEI, fips == "24510")

#Plots graph with regression lines to show trends and reduces ylim to better 
#show trends
g<-ggplot(x0, aes(year, Emissions))+geom_point(color = "steelblue", size = 4, 
                                               alpha = 1/2)+
  facet_grid(.~type)+geom_smooth(method = "lm", col = "red")+
  coord_cartesian(ylim = c(0, 100))+
  labs(title = "Annual PM2.5 Emissions by Type in Baltimore City", 
       y = "PM2.5 Emmisions [ton]", x = "Year")

#Creates png file
png(filename = "Plot3.png")
print(g)
dev.off() #Closes device