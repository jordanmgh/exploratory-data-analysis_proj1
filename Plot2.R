
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
#Cast Global Active Power to numeric type
shpc$Global_active_power <- as.numeric(shpc$Global_active_power)

# SECTION 2:  Generate, format, and save the plot ---------------------------------------------------------------------------  

plot.new()
#Set the output to target file
png(file="plot2.png")
#Generate plot
plot(shpc$DateTime,shpc$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
#Save file
dev.off()

