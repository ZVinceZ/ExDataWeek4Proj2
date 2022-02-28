#Reads files
NEI <- readRDS("summarySCC_PM25.rds")

#Creates Subset of Baltimore City data (fips == "24510")
BaltSub <- subset(NEI, fips == "24510")

#Collects the sum of the emissions for each year in an array
x0 <- with(BaltSub, tapply(Emissions, year, sum))

#Converts the array into a data frame and converts the year into a numeric 
d0 <- data.frame(Year = as.numeric(names(x0)), Sum = x0)

#Creates png file
png(filename = "Plot2.png")

#Plots graph with regression line to show trend
with(d0, plot(Year, Sum, main = "Total PM2.5 Emmisions Measured per Year in
              Baltimore City", ylab = "Total PM2.5 Emmissions [tons]", 
              xlab = "Year"))
abline(lm(Sum ~ Year, d0), col = "red")

dev.off() #Closes device