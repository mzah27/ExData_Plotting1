
library(plyr)
install.packages("grDevices")
library(grDevices)

### Reading and Filtering data 
data <- read.csv("household_power_consumption.txt", sep=";")
SelectedData <- subset(data, (Date == "1/2/2007" | Date == "2/2/2007")) 
####

### converting class type of Global Active power to numeric
SelectedData <- cbind(SelectedData, Global_active_power1 = as.numeric(as.character(SelectedData$Global_active_power)))


### Connecting the Columns of Date and Time and Transforming them into a Date/Time class type 
SelectedData <- cbind(SelectedData, DateTime = paste (SelectedData$Date,SelectedData$Time))
SelectedData <- cbind(SelectedData, DateTime2 = strptime (SelectedData$DateTime, format = "%d/  %m/ %Y %H : %M : %S"))

### Openning png device
png(file="Plot2.png")

### Plotting Date/Time vs. Active Power
with(SelectedData, plot( DateTime2, Global_active_power1, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "" ))

###  closing png device
dev.off()



