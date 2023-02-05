                                                                                                                                            print('This file was created within RStudio')
print("And now it leaves on github")

##insert date as 5 FEB '23 1:02 PM EAT BY SW-MURIU


### import the necessary libraries
library(ggplot2)
library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)
hms::hms(hours = 12, minutes = 24)

## setting the colour pallete
colors = c("#CC1011", "#665555", "#05a399", "#cfcaca", "#f5e840", "#0683c9", "#e075b0")
colors

## Upload the data in question
april = read.csv(file.choose())
may = read.csv((file.choose()))
june = read.csv(file.choose())
july = read.csv(file.choose())
august = read.csv(file.choose())
september = read.csv(file.choose())


## combine the data sets
data = rbind(april, may, june, july, august, september)

## pull out the head of the data 
head(data)

## the data contains 
summary(data)

## make the data set a data frame
df <- data.frame(data)

## the data has over 4 million records
## subset for easier analysis
## use 20k random records from the data 
rand_df <- df[sample(nrow(df),size = 20000), ]


## convert the date.time columns into data and time
rand_df$Date.Time <- as.POSIXct(rand_df$Date.Time, format="%m/%d/%Y %H:%M:%S")
rand_df$Time <- format(as.POSIXct(data$Date.Time, format = "%m/%d/%Y %H:%M:%S"), format="%H:%M:%S")
rand_df$Date.Time <- ymd_hms(rand_df$Date.Time) 

head(rand_df)

## create individual columns for month, day and year for eased time series
rand_df$day <- factor(day(rand_df$Date.Time))
rand_df$month <- factor(month(rand_df$Date.Time, label = TRUE))
rand_df$year <- factor(year(rand_df$Date.Time))
rand_df$dayofweek <- factor(wday(rand_df$Date.Time, label = TRUE))

## pull out the head to observe changes made
head(rand_df)

## separate the variables in time distinctively 
rand_df$second <- factor(second(hms(rand_df$Date.Time)))
rand_df$minute <- factor(minute(hms(rand_df$Date.Time)))
rand_df$hour <- factor(hour(hms(rand_df$Date.Time)))