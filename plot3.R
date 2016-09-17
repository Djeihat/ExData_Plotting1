# This third plot is a line graph of the three different sub meters
# over the two day period.

## Let's look for the file first. If it doesn't exist, R will download it.
if(!file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")){
      url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url,dest="exdata%2Fdata%2Fhousehold_power_consumption.zip")
}
data<-unzip("~/exdata%2Fdata%2Fhousehold_power_consumption.zip")
# The data is a .txt file with ";" as a separator and "?" for NAs so let's use read.table.
# The dates we're concerned with are 2007-02-01 and 2007-02-02,
# which correspond to rows 66637:69517 of the full set, and since it's a mighty data set,
# let's read in only those rows.  It'll be faster too! Let's also name the columns.
dates<-read.table(data,header=T,stringsAsFactors=F,sep=";",
                  skip=66636,nrow=2880,na.strings="?",
                  col.names=c("Date",
                              "Time",
                              "GlobalActivePower",
                              "GlobalReactivePower",
                              "Voltage",
                              "GlobalIntensity",
                              "Submetering1",
                              "Submetering2",
                              "Submetering3"))

# Let's make the date and time columns one POSIXlt column so it's easier to 
# make graphs with.
dates$Time<-strptime(paste(dates$Date,dates$Time),
                     format="%d/%m/%Y %H:%M:%S")
# Now we'll create the line plot.
png(file="plot3.png")
plot(dates$Time,dates$Submetering1,type="l",xlab="",ylab="Energy sub metering")
lines(dates$Time,dates$Submetering2,col="red")
lines(dates$Time,dates$Submetering3,col="blue")
legend("topright",lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
dev.off()