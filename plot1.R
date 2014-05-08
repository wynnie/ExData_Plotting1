#1/2/2007 starts at row 66638 
#2/2/2007 ends at row 69517  (1440 minutes a day * 2)

#Read only required rows
#colClasses converts all columns to character strings (else they will be factors)
#col.names specifies the column names
#na.strings makes ? appear as NA
#no header row
#read.csv2 default separator is ";"
df <- read.csv2("household_power_consumption.txt",skip=66637,nrow=2880,
	colClasses = "character",
	col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
	"Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	na.strings = c("?"),
	header=FALSE
	)

#Double check that we start at 00:00 on 1/2/2007 and end at 23:59 on 2/2/2007
head(df)
tail(df)

#Convert data and time column to datetime format and store in separate column called DateTime
df$DateTime <- paste(as.character(df$Date),as.character(df$Time))
df$DateTime <- strptime(df$DateTime,format="%d/%m/%Y %H:%M:%S")

#Convert power readings to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)

#Plot
#Not using transparent background since the html instructions page has a white bg
#Transparent bg can be accomplished by png(file="plot1.png",bg="transparent")
#png default is 480x480
png(file="plot1.png")
hist(df$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",
	main="Global Active Power")
dev.off()



