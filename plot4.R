# if file doen't exist, download and unzip data

if (!file.exists("household_power_consumption.txt")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, "household_power_consumption.zip")
        unzip("household_power_consumption.zip")
}

# read all data

alldata <- read.table("household_power_consumption.txt", header = TRUE, 
                      sep = ";", na.strings = "?", stringsAsFactors=FALSE)

# convert Date colume to "Date class"
alldata$Date <- as.Date(alldata$Date, "%d/%m/%Y")

# subset desired date
data <- subset(alldata, alldata$Date == "2007-02-01"|alldata$Date =="2007-02-02")

# create datetime colume by combining Date and Time

data$datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")


par(mfcol = c(2,2))

# plot1

plot(data$datetime, data$Global_active_power, type = "n", xlab = "",
     ylab = "Global Active Power")
lines(data$datetime, data$Global_active_power)

# plot 2
plot(data$datetime, data$Sub_metering_1, type = "n", xlab = "", 
     ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_1)
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright",lty = 1, col=c("black","red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       bty = "n", y.intersp = 0.2)


# plot 3
plot(data$datetime, data$Voltage, type = "n", 
     xlab = "datetime", ylab = "Voltage")
lines(data$datetime, data$Voltage)

# plot 4
plot(data$datetime, data$Global_reactive_power, type = "n", 
     xlab = "datetime", ylab = "Global_reactive_power")
lines(data$datetime, data$Global_reactive_power)

# save to PNG file
dev.copy(png, "plot4.png", width = 760, height = 600)
dev.off()

