
library(plyr)

### Reading and Filtering data 
data <- read.csv("household_power_consumption.txt", sep=";")
SelectedData <- subset(data, (Date == "1/2/2007" | Date == "2/2/2007")) 
####

################ Setting the layout for plotting multiple plots ################
par (mfrow = c(2,2))

################### Preparation and Plotting plot1 ############################

### converting class type of Global Active power to numeric
SelectedData <- cbind(SelectedData, Global_active_power1 = as.numeric(as.character(SelectedData$Global_active_power)))

### Connecting the Columns of Date and Time and Transforming them into a Date/Time class type 
SelectedData <- cbind(SelectedData, DateTime = paste (SelectedData$Date,SelectedData$Time))
SelectedData <- cbind(SelectedData, DateTime2 = strptime (SelectedData$DateTime, format = "%d/  %m/ %Y %H : %M : %S"))

### Plotting Date/Time vs. Active Power  
with(SelectedData,plot(DateTime2, Global_active_power1, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "" ))
  
################################################################################

################### Preparation and Plotting plot2 ############################

### converting class type of Global Active power to numeric
SelectedData <- cbind(SelectedData, Voltage1 = as.numeric(as.character(SelectedData$Voltage)))
### Plotting Date/Time vs. Voltage
with (SelectedData, plot( DateTime2, Voltage1, type = "l",ylab = "Voltage", xlab = "datetime" ))


################################################################################


################### Preparation and Plotting plot3 ############################

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

### Plotting

with( ProfilePlot, plot (DateTime2,metering, type = "n", ylab = "Energy sub metering", xlab = " "))
with( subset(ProfilePlot, group == "1"),lines(DateTime2, metering, col = "black"))
with( subset(ProfilePlot, group == "2"),lines(DateTime2, metering, col = "red"))
with( subset(ProfilePlot, group == "3"),lines(DateTime2, metering, col = "blue"))
legend("topright", pch = "____", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

################################################################################

################### Preparation and Plotting plot4 ############################

### converting class type of Global Active power to numeric
SelectedData <- cbind(SelectedData, Global_reactive_power1 = as.numeric(as.character(SelectedData$Global_reactive_power)))

### Plotting Date/Time vs. reActive Power
with(SelectedData, plot( DateTime2, Global_reactive_power1, type = "l",ylab = "Global_ reactive_power", xlab = "datetime" ))

################################################################################


dev.copy(png,file="Plot4.png")


###  closing png device
dev.off()



