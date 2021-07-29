
# SECTION 1:  Get data, add combined date/time field, cast numeric and date fields where necessary, filter for only relevant dates --------------- 

#Add lubridate to facilitate combining date and time
library(lubridate)
#read source data from working directory
hpc <- read.delim(file="household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)
#Set date to appropriate type
hpc$Date <- as.Date(hpc$Date,tryFormats="%d/%m/%Y")
#build date/time field
hpc$DateTime = (hpc$Date + hms(hpc$Time))
#Subset the days we want to look at
shpc <- subset.data.frame(hpc,(hpc$Date >= as.Date("2007-02-01") & hpc$Date <= as.Date("2007-02-02")))
#Set Global Active Power to appropriate type
shpc$Global_active_power <- as.numeric(shpc$Global_active_power)

# SECTION 2:  Generate, format, and save the plot ---------------------------------------------------------------------------  

plot.new()
#Set the output to target file
png(file="plot4.png")
#Generate plot and add lines
par(mfrow = c(2, 2))
#1st cell
plot(shpc$DateTime,shpc$Global_active_power,type="l",ylab="Global Active Power",xlab="")
#2nd cell
plot(shpc$DateTime,shpc$Voltage,type="l",ylab="Voltage",xlab="datetime")
#3rd cell
plot(shpc$DateTime,shpc$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(shpc$DateTime,shpc$Sub_metering_2,col="red")
lines(shpc$DateTime,shpc$Sub_metering_3,col="blue")
#3rd cell-add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), lty = 1:1, cex=.90,bty = "n")
#4th cell
with(shpc,plot(DateTime,Global_reactive_power,type="l",xlab="datetime"))
axis(side=2, at=seq(0.0,0.5,by=0.1))

#Save file
dev.off()

