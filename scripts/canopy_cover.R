############################################################# 
# Author: Meagan Ng
# Date: Feb 4 2022
# Topic: FCOR 599 Project Canopy Cover
############################################################# 

##### Import packages ####

library(here)
library(lidR)
library(raster)
library(tidyverse)
library(terra)
library(sf)

#### Read in data ####

lidardata <- readLAScatalog("data/LAS")

#### Analyze data #### 

las_check(lidardata) # Inspect lidardata
summary(lidardata) # Summary of lidardata
plot(lidardata) # Plot lidardata

# Create DEM to use to normalize the data
UBC_DEM <- grid_terrain(lidardata, 2, tin()) # Using spatial interpolation to create DEM

#Create color palatte
col_1 <- height.colors(50) # Assign a colour palatte

#Plot DEM using color palatte
plot(UBC_DEM, col = col_1) # Plot in 2D
#plot_dtm3d(UBC_DEM) # Plot in 3D **DO NOT RUN IF YOUR COMPUTER IS SLOW**

# Define LAScatalog engine options
opt_output_files(lidardata) <- ("data/Normalized/norm_ubcbg_{ID}") # Setting directory for where the file will go

# Normalize all tiles in lidardata with the DEM 
norm_tiles_ubcbg <- normalize_height(lidardata, UBC_DEM)

# Check to see if the normalization worked
norm_ubcbg_1 <- readLAS(here("data/Normalized/norm_ubcbg_1.las")) # Read in the normalized tiles of norm_ubcbg
plot(norm_ubcbg_1) # Visualize the normalized norm_ubcbg (rgl)

##### Read in normalized data ####

ctg <- catalog(here("data/Normalized")) # Create catalog of normalized data

opt_filter(ctg) <- "-keep_first" # Filter for first returns 

#### Grid metrics ####

my_metrics <- grid_metrics(ctg, .stdmetrics_z, res = 2) # Create metrics with a resolution of 2m

my_metrics <- terra::rast(my_metrics) # Read in metrics

terra::writeRaster(my_metrics, 
                   filename = file.path("data/Z_METRICS",
                                        paste0(names(my_metrics), ".tif")), 
                   overwrite = TRUE)

cover <- my_metrics$pzabove2 # Assign pzabove2 (canopy cover)

plot(cover) # Plot canopy cover 


