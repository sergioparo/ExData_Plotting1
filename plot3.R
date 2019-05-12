library(sqldf)
# read only required dates using sqldf read.csv.sql function
EPC <- read.csv.sql (file="household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
# convert character columns to datetime column
EPC$DateTime <- paste(EPC$Date, EPC$Time, sep = " ")
EPC$DateTime <- strptime(EPC$DateTime, format="%d/%m/%Y %H:%M:%S")

# locale to get english weekdays on my computer
Sys.setlocale("LC_TIME", "C")


# Plot 3
# plot a Energy Sub metering x DateTime graph
png(file="plot3.png", width = 480, height = 480)
plot(EPC$DateTime, EPC$Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering", col="Black")
# add lines Rec and Blue for sub_metering_2 and sub_metering_3 respectively
lines(EPC$DateTime, EPC$Sub_metering_2, col="Red")
lines(EPC$DateTime, EPC$Sub_metering_3, col="Blue")
# add the legend on top righ position
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("Black", "Red", "Blue"), lty =1)
dev.off()