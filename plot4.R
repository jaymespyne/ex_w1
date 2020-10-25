getwd()
setwd('C:\\Users\\Jaymes Pyne\\Google Drive\\1_Stanford_Pyne\\Classes\\Coursera\\Data_Science_Specialization\\4 Exploratory Data Analysis')
file.exists("directoryname")
#create a data directory if one does not exist
files<-c("1_Scripts","2_Data","3_Tables","4_Graphs", 
	   "5_Logs","6_Estimates","7_Notes")
for(f in files) {
	if(!file.exists(f)) {
		dir.create(f)
	}
}
hpc<-read.table("./2_Data/household_power_consumption.txt",sep=";",header=T)
hpc2<-hpc[which(hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007"),]
hpc2$date<-paste(hpc2$Date,hpc2$Time)
hpc2$time<-as.POSIXct(hpc2$date,format="%d/%m/%Y %H:%M:%S")

hpc2$sub1<-as.numeric(hpc2$Sub_metering_1)
hpc2$sub2<-as.numeric(hpc2$Sub_metering_2)
hpc2$sub3<-as.numeric(hpc2$Sub_metering_3)

hpc2$gap<-as.numeric(hpc2$Global_active_power)
hpc2$voltage<-as.numeric(hpc2$Voltage)
hpc2$grp<-as.numeric(hpc2$Global_reactive_power)

hpc3<-hpc2[complete.cases(hpc2),c("gap","voltage","grp","sub1","sub2","sub3","time")]

png(file="./4_Graphs/plot4.png")
par(mfrow=c(2,2))
plot(hpc3$time,hpc3$gap,ylab="Global Active Power",type="l")
plot(hpc3$time,hpc3$voltage,ylab="Voltage",xlab="datetime",type="l")
plot(hpc3$time,hpc3$sub1,type="l",col="Black",
     		xlab="",ylab="Energy sub metering")
	lines(hpc3$time,hpc3$sub2,type="l",col="Red",
    		xlab="",ylab="Energy sub metering")
	lines(hpc3$time,hpc3$sub3,type="l",col="Blue",
     		xlab="",ylab="Energy sub metering")
	legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
		lty=c(1,1,1),col=c("black","red","blue"))
plot(hpc6$time,hpc6$grp,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
