


# SECTION 1:  get data, Cast numeric, date/time fields where necessary, filter for only required dates --------------- 

#read source data from working directory
hpc <- read.delim(file="household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)
#Set date to appropriate type
hpc$Date <- as.Date(hpc$Date,tryFormats="%d/%m/%Y")
#Subset the days we want to look at
shpc <- subset.data.frame(hpc,(hpc$Date >= as.Date("2007-02-01") & hpc$Date <= as.Date("2007-02-02")))
#Set Global Active Power to appropriate type
shpc$Global_active_power <- as.numeric(shpc$Global_active_power)

# SECTION 2:  Generate, format, save plot  --------------------------------------------------------------------------- 

plot.new()
#Set the output to target file
png(file="plot1.png")
#Generate plot
hist(shpc$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
#Save file
dev.off()

