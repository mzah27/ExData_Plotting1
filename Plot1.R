
library(plyr)
install.packages("grDevices")
library(grDevices)

### Reading and Filtering data 
data <- read.csv("household_power_consumption.txt", sep=";")
SelectedData <- subset(data, (Date == "1/2/2007" | Date == "2/2/2007")) 
####


### converting class type of Global Active power to numeric
SelectedData <- cbind(SelectedData, Global_active_power1 = as.numeric(as.character(SelectedData$Global_active_power)))

### Openning png device
png(file="Plot1.png")

### plotting
hist(SelectedData$Global_active_power1, col = "red", xlab = "Global Active Power (kilowatts)")

###  closing png device
dev.off()



