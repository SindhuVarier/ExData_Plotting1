setwd(".//eda//exdata%2Fdata%2Fhousehold_power_consumption")
getwd()
hpower<- read.csv("household_power_consumption.txt",header = TRUE,sep=";",stringsAsFactors = FALSE)
object.size(hpower)
summary(hpower)
str(hpower)

#hpower<-within(hpower,{timestamp=format(as.POSIXct(paste(hpower$Date, hpower$Time),format="%d/%m/%Y %H:%M:%S"),"%Y-%m-%d %H:%M:%S")})
hpower$timestamp <- paste(hpower$Date, hpower$Time)
hpower$timestamp <- strptime(hpower$timestamp, "%d/%m/%Y %H:%M:%S")


hpower$Date <- as.Date(hpower$Date, format="%d/%m/%Y")
head(hpower)
fromDt <- as.Date("2007-02-01")
toDt <- as.Date("2007-02-02")
hpowerDay <- hpower[ which( hpower$Date >= fromDt & hpower$Date <= toDt) , ]
summary(hpowerDay)
head(hpowerDay)
hpowerDay$Global_active_power <- as.numeric(hpowerDay$Global_active_power)
hpowerDay$Global_reactive_power <-as.numeric(hpowerDay$Global_reactive_power)
hpowerDay$Voltage <- as.numeric(hpowerDay$Voltage)
hpowerDay$Global_intensity <- as.numeric(hpowerDay$Global_intensity)
hpowerDay$Sub_metering_1 <- as.numeric(hpowerDay$Sub_metering_1)
hpowerDay$Sub_metering_2 <- as.numeric(hpowerDay$Sub_metering_2)
hpowerDay$Sub_metering_3 <- as.numeric(hpowerDay$Sub_metering_3)

par(mar=c(5.1,4.1,0.5,2.1))
par(mfrow=c(2,2))

plot(hpowerDay$timestamp,hpowerDay$Global_active_power,xaxt="n",type="l",ylab="Global Active Power",xlab="")
axis.POSIXct(1,at=seq(fromDt,toDt,by="day"),format="%a")

plot(hpowerDay$timestamp,hpowerDay$Voltage,xaxt="n",type="l",ylab="Voltage",xlab="datetime")
axis.POSIXct(1,at=seq(fromDt,toDt,by="day"),format="%a")

plot(hpowerDay$timestamp,hpowerDay$Sub_metering_1,type="l",xaxt="n",ylab="Energy sub metering",xlab="",col="black")
lines(hpowerDay$timestamp, hpowerDay$Sub_metering_2, col = "red")
lines(hpowerDay$timestamp, hpowerDay$Sub_metering_3, col = "blue")
axis.POSIXct(1,at=seq(fromDt,toDt,by="day"),format="%a")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),cex=0.6)

plot(hpowerDay$timestamp,hpowerDay$Global_reactive_power,xaxt="n",type="l",ylab="Global Reactive Power",xlab="datetime")
axis.POSIXct(1,at=seq(fromDt,toDt,by="day"),format="%a")


dev.copy(png,file="plot4.png")
dev.off()