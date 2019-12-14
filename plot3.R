## Load the data
## Only first 160.000 rows loaded, as they contain more then 2 days needed 

library(dplyr)

raw<-read.csv("household_power_consumption.txt", nrows=160000, sep=";", dec=".", stringsAsFactors=FALSE)
raw$Date<-as.Date(raw$Date,"%d/%m/%Y")

raw$Time<-strptime(paste(raw$Date,raw$Time),"%Y-%m-%d %H:%M:%S")
raw$Time<-as.POSIXct.POSIXlt(raw$Time)
sub<-filter(raw,Date==as.Date("01/02/2007","%d/%m/%Y")|Date==as.Date("02/02/2007","%d/%m/%Y"))
sub$Global_active_power<-as.numeric(sub$Global_active_power)
sub$Sub_metering_1<-as.numeric(sub$Sub_metering_1)
sub$Sub_metering_2<-as.numeric(sub$Sub_metering_2)
sub$Sub_metering_3<-as.numeric(sub$Sub_metering_3)

png(filename = "plot3.png", width = 480, height = 480, units = "px")

plot(sub$Time,sub$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="",main="", col="black")

lines(sub$Time,sub$Sub_metering_2,col="red",type="l")

lines(sub$Time,sub$Sub_metering_3,col="blue",type="l")

legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

dev.off()
