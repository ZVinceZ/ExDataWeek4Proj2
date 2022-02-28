library(ggplot2)

#Reads files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge data of both data sets (it takes the SCC# as the commonality)
merged <- merge(NEI, SCC, all = TRUE)

#Creates a subset of the data related to Coal Combustion
x1 <- subset(merged, EI.Sector == "Fuel Comb - Electric Generation - Coal" |
                 EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal" |
                 EI.Sector == "Fuel Comb - Comm/Institutional - Coal")

#Plots graph with regression line to show trend and reduces ylim to better 
#show trend
g<-ggplot(x1, aes(year, Emissions))+
  geom_point(color = "steelblue", size = 4, alpha = 1/10)+
  geom_smooth(method = "lm", col = "red")+
  coord_cartesian(ylim = c(0, 1000))+
  labs(title = "Annual PM2.5 Emissions from Coal Combustion in the US", 
       y = "PM2.5 Emmisions [ton]", x = "Year")

#Creates png file
png(filename = "Plot4.png")
print(g)
dev.off() #Closes device