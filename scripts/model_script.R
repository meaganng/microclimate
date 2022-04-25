############################################################# 
# Author: Meagan Ng
# Date: April 9 2022
# Topic: LST Model against LiDAR Metrics
############################################################# 

##### Install and/or load packages ####
library(lidR)
library(tidyverse)
library(here)
library(raster)
library(terra)
library(sf)
library(car)


#### Read in data ####

randompointdata <- st_read("data/randompointdata.shp") # Read in 100 random points data

#### Model LST and CC ####

# Fit a empty model
model1= lm(lstvalue ~ 1, data = randompointdata) # rastervalu is the LST

# Now, add in one variable at time, and select the most significant
add1(model1,~ pzabove2va + zkurtvalue + zmaxvalue + zskewvalue, test = 'F')


# Fit a linear model using multiple predictors (separating the predictors by '+' sign)
model1 = lm(lstvalue ~ pzabove2va + zmaxvalue, data = randompointdata)

#Display a summary of the model with the predictors
summary(model1)  

pairs(~ lstvalue + pzabove2va + zmaxvalue, data = randompointdata) # Check to see correlation

#Display a summary of the model
summary(model1) 


# Plot LST and fitted values
plot(randompointdata$lstvalue ~ model1$fitted.values, xlab = 'Predicted', ylab = 'Measured', main = "LST Modelled Against Canopy Cover and Maximum Height")
abline(0,1, col = "red")

#Create function from model LST coefficients
f <- function(a,b){
  (-0.007739 *a) + (-0.042072*b) + 61.789420          
}

#### Unpaired t-test ####

# Read in data
ttestcsv <- read.csv(here("data/ttestrandompoints.csv")) # .csv data is populated from selecting by attributes on ArcGIS Pro 

t.test(ttestcsv$above0, ttestcsv$X0, alternative = "two.sided", var.equal = FALSE) 
