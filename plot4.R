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
png(file = "plot4.png")

## Set graphical parameters to create a 2 x 2 layout
par(mfrow = c(2, 2))

## Plot 4 line graphs
with(ElecPwrConTblFeb1_2, { 
    plot(DateTime, Global_active_power, 
         type = "l", ylab = "Global Active Power", xlab="")
    
    plot(DateTime, Voltage, 
         type = "l", ylab = "Voltage", xlab="datetime")
    
    plot(ElecPwrConTblFeb1_2[,"DateTime"], ElecPwrConTblFeb1_2[, "Sub_metering_1"], 
         type = "l", col = "black", ylab = "Energy sub metering", xlab="")
    lines(ElecPwrConTblFeb1_2[,"DateTime"], ElecPwrConTblFeb1_2[, "Sub_metering_2"], 
          type = "l", col= "red")
    lines(ElecPwrConTblFeb1_2[,"DateTime"], ElecPwrConTblFeb1_2[, "Sub_metering_3"], 
          type = "l", col= "blue")
    legend("topright", pch = 151, cex = 0.75, bty = "n", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(DateTime, Global_reactive_power, 
         type = "l", xlab="datetime")
})

## Close Graphics device
dev.off()