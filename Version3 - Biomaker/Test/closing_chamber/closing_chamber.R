setwd("~/GitHub/camara-respiracion-suelo/Versionn 3 - Biomaker/Test/test3sens")
rm(list=ls())


library(lubridate)
library(tidyr)
library(tidyverse)
library(zoo)

## Closed chamber test

mhz19_1<-read_csv("MH-z19_closed chamber_1.csv")
mhz16_1<-read_csv("MH-z16_closed chamber_1.csv")
scd41_1<-read_csv("SDC41_closed chamber_1.csv")

# Add more measurementes after a turn-off

mhz19_2<-read_csv("MH-z19_closed chamber_2.csv")
mhz16_2<-read_csv("MH-z16_closed chamber_2.csv")
scd41_2<-read_csv("SDC41_closed chamber_2.csv")
mhz19<-rbind(mhz19_1,mhz19_2)
mhz16<-rbind(mhz16_1,mhz16_2)
scd41<-rbind(scd41_1,scd41_2)

summary(mhz19$Medición)
summary(mhz16$Medición)
summary(scd41$Medición)

ggplot() +               
  geom_line(aes(scd41$TimeStamp,scd41$Medición, color = "black") ) +  
  geom_line(aes(mhz19$TimeStamp,mhz19$Medición, color = "green")) +
  geom_line(aes(mhz16$TimeStamp,mhz16$Medición, color = "blue")) +
  geom_vline(xintercept = as.POSIXct("2022-04-02 17:03", tz = "UTC"),color="red") + 
  labs(x = "Time", y = "CO2 ppm") +
  scale_color_manual(labels = c('SCD41', 'MHZ19', 'MHZ16'),
                     values = c('black', 'green', 'blue')) +
  ggtitle("Empty chamber")

datos <- bind_rows(
  mhz19=mhz19,
  mhz16=mhz16,
  scd41=scd41,
  .id = "sensor"
)

datos %>% 
  filter(TimeStamp >= as.POSIXct("2022-04-02 17:15", tz = "UTC")) %>% 
  ggplot() +               
  geom_line(aes(x=TimeStamp, y=Medición, color = sensor)) +
  #geom_vline(xintercept = as.POSIXct("2022-04-02 17:03, tz = "UTC"")) + 
  labs(x = "Time", y = "CO2 ppm") +
  scale_color_manual(values = c('black', 'green', 'blue')) +
  ggtitle("Emptly chamber - Closed chamber")


## Open window test
mhz19_ow<-read_csv("MH-z19_open window.csv")
mhz16_ow<-read_csv("MH-z16_open window.csv")
scd41_ow<-read_csv("SDC41_open window.csv")
summary(mhz19_ow$Medición)
summary(mhz16_ow$Medición)
summary(scd41_ow$Medición)

ggplot() +               
  geom_line(aes(scd41_ow$TimeStamp,scd41_ow$Medición), 
            color = "black")+  
  geom_line(aes(mhz19_ow$TimeStamp,mhz19_ow$Medición),
             color = "green")+
  geom_line(aes(mhz16_ow$TimeStamp,mhz16_ow$Medición),
            color = "blue")+
  labs(x = "Time", y = "CO2 ppm")+
  ggtitle("Black-SCD41 & Green-MHZ19 & Blue-MHZ16")

# Rewetted soil test

mhz19_rw_1<-read_csv("MH-z19_rewetted soil.csv")
mhz16_rw_1<-read_csv("MH-z16_rewetted soil.csv")
scd41_rw_1<-read_csv("SDC41_rewetted soil.csv")

# add more measurements after turn-off
mhz19_rw_2<-read_csv("MH-z19_rewetted soil_1.csv")
mhz16_rw_2<-read_csv("MH-z16_rewetted soil_1.csv")
scd41_rw_2<-read_csv("SDC41_rewetted soil_1.csv")
mhz19_rw<-rbind(mhz19_rw_1,mhz19_rw_2)
mhz16_rw<-rbind(mhz16_rw_1,mhz16_rw_2)
scd41_rw<-rbind(scd41_rw_1,scd41_rw_2)

summary(mhz19_rw)
summary(mhz16_rw)
summary(scd41_rw)

ggplot() +               
  geom_line(aes(scd41_rw$TimeStamp,scd41_rw$Medición), 
            color = "black")+  
  geom_line(aes(mhz19_rw$TimeStamp,mhz19_rw$Medición),
            color = "green")+
  geom_line(aes(mhz16_rw$TimeStamp,mhz16_rw$Medición),
            color = "blue")+
  labs(x = "Time", y = "CO2 ppm")+
  ggtitle("Black-SCD41 & Green-MHZ19 & Blue-MHZ16")
