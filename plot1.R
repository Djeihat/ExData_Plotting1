# This first plot is a histogram of the Global Active Power in kilowatts
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

# Now we'll create the histogram.
png(file="plot1.png")
hist(dates$GlobalActivePower,col="red",
     xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
