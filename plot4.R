library(sqldf)
# read only required dates using sqldf read.csv.sql function
EPC <- read.csv.sql (file="household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
# convert character columns to datetime column
EPC$DateTime <- paste(EPC$Date, EPC$Time, sep = " ")
EPC$DateTime <- strptime(EPC$DateTime, format="%d/%m/%Y %H:%M:%S")

# locale to get english weekdays on my computer
Sys.setlocale("LC_TIME", "C")

# Plot 4
# plot a set of 4 graphs
png(file="plot4.png", width = 480, height = 480)
# set the configuration of 2x2 charts 
par(mfrow=c(2,2))
# first chart: toplef
plot(EPC$DateTime, EPC$Global_active_power, type="l", xlab="", ylab = "Global Active Power")
# second chart: topright
plot(EPC$DateTime, EPC$Voltage, type="l", xlab="datetime", ylab = "Voltage")
# third chart: bottomleft
plot(EPC$DateTime, EPC$Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering", col="Black")
# add lines Rec and Blue for sub_metering_2 and sub_metering_3 respectively
lines(EPC$DateTime, EPC$Sub_metering_2, col="Red")
lines(EPC$DateTime, EPC$Sub_metering_3, col="Blue")
# add the legend on top righ position
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("Black", "Red", "Blue"), lty =1, bty = "n")
# fourth chart: bottomright
plot(EPC$DateTime, EPC$Global_reactive_power, type="l", xlab="datetime", ylab = "Global_reactive_power")
dev.off()