
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
png(file="plot3.png")
#Generate plot and add lines
plot(shpc$DateTime,shpc$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(shpc$DateTime,shpc$Sub_metering_2,col="red")
lines(shpc$DateTime,shpc$Sub_metering_3,col="blue")
#add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), lty = 1:1, cex=.9,bty = "n")
#Save file
dev.off()

