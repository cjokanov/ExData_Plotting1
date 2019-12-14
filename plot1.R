## Load the data
## Only first 160.000 rows loaded, as they contain more then 2 days needed 

library(dplyr)

raw<-read.csv("household_power_consumption.txt", nrows=160000, sep=";", dec=".", stringsAsFactors=FALSE)
raw$Date<-as.Date(raw$Date,"%d/%m/%Y")

raw$Time<-strptime(paste(raw$Date,raw$Time),"%Y-%m-%d %H:%M:%S")
raw$Time<-as.POSIXct.POSIXlt(raw$Time)
sub<-filter(raw,Date==as.Date("01/02/2007","%d/%m/%Y")|Date==as.Date("02/02/2007","%d/%m/%Y"))
sub$Global_active_power<-as.numeric(sub$Global_active_power)


par(mfcol = c(1,1))

png(filename = "plot1.png", width = 480, height = 480, units = "px")

hist(sub$Global_active_power,col="red",xlab="Global Active Power (killowatts)",ylab="Frequency",main="Global Active Power")

dev.off()

