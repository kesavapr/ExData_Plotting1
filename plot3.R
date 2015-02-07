library(lubridate)

## Read data file. Treat data files with "?" as NA
## The data should be located in "./exdata_data_household_power_consumption" directory
ElectricPwrCon <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", 
                             sep = ";", header = TRUE, na.strings = "?", 
                             colClasses = c("character", "character", "numeric", 
                                            "numeric", "numeric", "numeric",
                                            "numeric", "numeric", "numeric"))

## Convert Date string to POSIXct object
ElectricPwrCon$Date <- dmy(ElectricPwrCon$Date)

Feb1 <- ymd("2007-02-01")
Feb2 <- ymd("2007-02-02")

## Subset data to just Feb 1, 2007 and Feb 2, 2007
ElecPwrConTblFeb1_2 <- subset(ElectricPwrCon, ElectricPwrCon$Date == Feb1 | 
                                  ElectricPwrCon$Date == Feb2)
rm(ElectricPwrCon)

## Combine Date and Time columns to create a new column of type POSIXlt
DateTime = as.POSIXlt(paste(ElecPwrConTblFeb1_2[, "Date"], 
                            ElecPwrConTblFeb1_2[, "Time"]))
ElecPwrConTblFeb1_2$DateTime <- DateTime

## Open PNG file
png(file = "plot3.png")

## Line plot and overlay lines for all required fields. Update Legend to appear at top right
with(ElecPwrConTblFeb1_2, {
    plot(DateTime, Sub_metering_1, type = "l", col = "black", 
         ylab = "Energy sub metering", xlab="")
    lines(DateTime, Sub_metering_2, type = "l", col= "red")
    lines(DateTime, Sub_metering_3, type = "l", col= "blue")  
    legend("topright", pch = 151, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))   
})

## Close Graphics device
dev.off()