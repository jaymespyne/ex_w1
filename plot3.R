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
hpc2$gap<-as.numeric(hpc2$Global_active_power)
hpc3<-hpc2[complete.cases(hpc2),c("gap","time")]

png(file="./4_Graphs/plot2.png")
plot(hpc3$time,hpc3$gap,type="l",
     xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

