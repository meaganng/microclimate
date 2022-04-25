# Understanding Microclimate in University of British Columbia's Botanical Garden
#### Using a multiple linear regression, a model was created to assess land surface temperature and LiDAR metrics.

## Due to size constraints, please visit the [MGEM Scholars Portal Dataverse](https://dataverse.scholarsportal.info/dataverse/UBC_MGEM) to download this project. 

![](images/UBCBG.jpg)

## Intoduction
Microclimate is defined as noticeable climatic conditions that differ from the temperatures outside of forests (De Frenne et. al 2021).

Climate change is a key factor in how extreme weather events affect how ecosystems and species react to these changes in temperatures (Harris et al., 2020).  Urban green spaces are becoming more important in providing resilience to climate change as many tall broad trees provide shade through canopy cover (Cheng et al., 2021). Acknowledging different microclimates is important in maintaining the ecosystem service for species residing or passing through these areas at the botanical gardens. These relief zones can be imperative during heatwaves and during migration or off-seasons, in letting species take comfort (Philpott & Bichier, 2012).  In addition, with climate change altering many species and their ranges, range shifts may occur making these relief zones a new suitable habitat for them to occupy (Valladares et al., 2016).

## Study Area
The UBC Botanical Garden is located on the University of British Columbia Vancouver Campus at latitude 49.25 decimal degrees and -123.25 decimal degrees.
I would like to acknowledge that UBC Botanical Garden is located on the traditional and unceded land of the xʷməθkʷəy̓əm Musqueam First Nation. 
They work towards the vision that plants are understood, valued, celebrated, and secure in a healthy, biodiverse world.
The campus is located in the Moist Maritime Coastal Douglas-fir Subzone (CDFmm) (BEC WEB, n.d.; CDFmm.Pdf, n.d.). It is one of the oldest university botanic gardens and sits at 37 hectares (About Us, n.d.). It was originally established 100 years ago and now hosts many native and non-native cultivated plants.

![](maps/DataSite.png)

## Methods
#####Canopy Cover
LiDAR metrics were derived using LiDAR data flown around the UBC Campus in 2021. Canopy cover was calculated in RStudio using the lidR package (Roussel, 2021). LiDAR grid metrics were calculated for first returns only. Trees were filtered to be taller than 2 meters.


#####Land Surface Temperature
A land surface temperature (LST) map was created from calculating LST in ArcGIS Pro. This is a five step process that includes calculating top of atmospheric spectral radiance, a brightness temperature conversion, a Normalized Difference Vegetation Index (NDVI), proportion of vegetation, and emissivity.


#####Modelling Using Multiple Linear Regression
A model was created to analyze land surface temperature with LiDAR metrics on 100 points inside UBC Botanical Garden. Using canopy cover (pzabove2) and the maximum height in the stand (zmaxvalue) in the model led to valuable results. The model was created in RStudio using R programming language. 


