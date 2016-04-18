library(plyr)
install.packages("grDevices")
library(grDevices)
library(dplyr)

### Reading and Filtering data 
data <- read.csv("household_power_consumption.txt", sep=";")
SelectedData <- subset(data, (Date == "1/2/2007" | Date == "2/2/2007")) 
####



#### adding meter values of sub-meter1 and assigning group=1
temp <- select( SelectedData, Date:Global_intensity)
temp <- cbind(temp, metering = as.numeric(as.character(SelectedData$Sub_metering_1)))
temp <- cbind (temp, group = "1")
ProfilePlot <- select(temp, Date:group)

#### adding meter values of sub-meter2 and assigning group=2
temp <- select( SelectedData, Date:Global_intensity)
temp <- cbind(temp, metering = as.numeric(as.character(SelectedData$Sub_metering_2)))
temp <- cbind (temp, group = "2")
ProfilePlot <- rbind(ProfilePlot, temp)

#### adding meter values of sub-meter3 and assigning group=3
temp <- select( SelectedData, Date:Global_intensity, metering = as.numeric(Sub_metering_3))
temp <- cbind (temp, group = "3")
ProfilePlot <- rbind(ProfilePlot, temp)


### Connecting the Columns of Date and Time and Transforming them into a Date/Time class type 
ProfilePlot <- cbind(ProfilePlot, DateTime = paste (ProfilePlot$Date,ProfilePlot$Time))
ProfilePlot <- cbind(ProfilePlot, DateTime2 = strptime (ProfilePlot$DateTime, format = "%d/  %m/ %Y %H : %M : %S"))

### Openning png device
png(file="Plot3.png")

### Plotting

with( ProfilePlot, plot (DateTime2,metering, type = "n", ylab = "Energy sub metering", xlab = " "))
with( subset(ProfilePlot, group == "1"),lines(DateTime2, metering, col = "black"))
with( subset(ProfilePlot, group == "2"),lines(DateTime2, metering, col = "red"))
with( subset(ProfilePlot, group == "3"),lines(DateTime2, metering, col = "blue"))
legend("topright", pch = "____", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

###  closing png device
dev.off()


