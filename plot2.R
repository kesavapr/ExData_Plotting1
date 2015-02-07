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
png(file = "plot2.png")

## Line Plot 
with(ElecPwrConTblFeb1_2, {
    plot(DateTime, Global_active_power, 
         type = "l", ylab = "Global Active Power (kilowatts)", xlab="")
})

## Close Graphics device
dev.off()