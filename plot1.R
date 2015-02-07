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

## Open PNG file
png(file = "plot1.png")

## Plot histogram and set x-axis label
hist(ElecPwrConTblFeb1_2$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

## Close Graphics device
dev.off()
