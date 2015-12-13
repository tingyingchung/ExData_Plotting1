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

# plot histogram

hist(data$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

# save to PNG file
dev.copy(png, "plot1.png", width = 760, height = 600)
dev.off()

