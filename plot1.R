library(sqldf)
# read only required dates using sqldf read.csv.sql function
EPC <- read.csv.sql (file="household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
# convert character columns to datetime column
EPC$DateTime <- paste(EPC$Date, EPC$Time, sep = " ")
EPC$DateTime <- strptime(EPC$DateTime, format="%d/%m/%Y %H:%M:%S")

# locale to get english weekdays on my computer
Sys.setlocale("LC_TIME", "C")


# Plot 1
# plot a histogram to png destination
png(file="plot1.png", width = 480, height = 480)
hist(EPC$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col = "Red")
dev.off()