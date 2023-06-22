# Library
library(ggplot2)
library(lubridate)
library(tidyr)
library(tidyverse)
library(hrbrthemes)

setwd("~/GitHub/camara-respiracion-suelo/Versionn 3 - Biomaker/Test")

mhz19<-read_csv("MH-z19 cámara cerrada.csv")

windowsFonts("Arial" = windowsFont("Arial"))

ggplot(mhz19, aes(x=mhz19$TimeStamp, y=mhz19$Medición)) +
  geom_point() + 
  geom_smooth(method="lm" , color="red", fill="#69b3a2", se=TRUE) +
  theme_ipsum()

scd41<-read_csv("SCD41 closed chamber.csv")
ggplot(scd41, aes(x=scd41$TimeStamp, y=scd41$Medición)) +
  geom_point() + 
  geom_smooth(method="lm" , color="red", fill="#69b3a2", se=TRUE) +
  theme_ipsum()



ggplot() +               
  geom_point(aes(scd41$TimeStamp[1:323],scd41$Medición[1:323]), 
             color = "black")+  
  geom_point(aes(mhz19$TimeStamp,mhz19$Medición),
             color = "green")+
  labs(x = "Time", y = "CO2 ppm")+
  ggtitle("Black-SCD41 & Green-MHZ19")
