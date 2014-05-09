#all_data<-read.table(file="household_power_consumption.txt", sep=";",header=TRUE,colClasses=c("character","character",rep("numeric",7)),na.string="?")
#data<-subset(all_data,all_data$Date %in% c("2007-02-01","2007-02-02"))
# Instead of import all data and filter later (as shown above), I skipped unnecessary rows, only read specific rows (start from row 66637, total 2880 rows)

# Data import

data<-read.table(file="household_power_consumption.txt", sep=";",col.name=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),colClasses=c("character","character",rep("numeric",7)),na.string="?",skip=66637,nrows=2880)

# Paste date and time to generate field with both date and time

data$Time<-paste(data$Date,data$Time,sep=" ")

# Convert character to datetime and date

data$Time<-strptime(data$Time,format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date,format="%d/%m/%Y")

# Plotting multi-varible line graph

png(file="plot1.png",width=480, height=480)

with(data,plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(data,lines(Time,Sub_metering_2,type="l",col="red"))
with(data,lines(Time,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))

dev.off()
