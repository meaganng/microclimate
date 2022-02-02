############################################################# 
# Author: Meagan Ng
# Date: Jan 27 2022
# Topic: FCOR 599 Project LST
############################################################# 

##### Import packages ####
library(here)
library(raster)
library(RStoolbox)
library(tidyverse)
library(sf)
library(terra)

#### Read in data ####

#Values from Metafile
RADIANCE_MULT_BAND_10 <- 3.3420E-04
RADIANCE_MULT_BAND_11 <- 3.3420E-04

RADIANCE_ADD_BAND_10 <- 0.10000
RADIANCE_ADD_BAND_11 <- 0.10000

band_10 <- raster("data/landsat/LC08_L2SP_047026_20210630_20210708_02_T1_ST_B10.tif") #change image name accordingly
band_11 <- raster("data/landsat/LC08_L2SP_047026_20210630_20210708_02_T1_ST_B10.tif") #change image name accordingly

#Calculate TOA from DN:
toa_band10 <- calc(band_10, fun=function(x){RADIANCE_MULT_BAND_10 * x + RADIANCE_ADD_BAND_10})
toa_band11 <- calc(band_11, fun=function(x){RADIANCE_MULT_BAND_11 * x + RADIANCE_ADD_BAND_11})

#Values from Metafile
K1_CONSTANT_BAND_10 <- 774.8853
K1_CONSTANT_BAND_11 <- 480.8883
K2_CONSTANT_BAND_10 <- 1321.0789
K2_CONSTANT_BAND_11 <- 1201.1442

#Calculate LST in Kelvin for Band 10 and Band 11
temp10_kelvin <- calc(toa_band10, fun=function(x){K2_CONSTANT_BAND_10/log(K1_CONSTANT_BAND_10/x + 1)})
temp11_kelvin <- calc(toa_band11, fun=function(x){K2_CONSTANT_BAND_11/log(K1_CONSTANT_BAND_11/x + 1)})

#Convert Kelvin to Celsius for Band 10 and 11
temp10_celsius <- calc(temp10_kelvin, fun=function(x){x - 273.15})
temp11_celsius <- calc(temp11_kelvin, fun=function(x){x - 273.15})

#Export raster images
writeRaster(temp10_celsius, "temp10_c.tif")
writeRaster(temp11_celsius, "temp11_c.tif")

lst_10 <- raster("temp10_c.tif")
plot(lst_10, r = 3, g = 2, b = 1, stretch = "lin")


garden <- read_sf('data/asian_garden/asian_garden.shp', quiet = T)
garden_proj <- st_transform(garden, st_crs(band_10))
garden_clip <- crop(band_10, garden_proj)

plotRGB(garden_clip, r = 3, g = 2, b = 1, stretch = "lin")

plot(garden_clip, main = "Land Surface Temperature of UBC Botanical Gardens")
plot(temp10_celsius)
     