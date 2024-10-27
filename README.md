
# global_gender_inequality

<!-- badges: start -->
<!-- badges: end -->

## Data Sources

1. Gender Inequality Index: from the “All composite indices and components time series (1990-2022)” dataset

2. World Geographic Data: A .geojson file with country boundaries used for spatial visualization.

## Analysis Steps

1. Data Preparation:
·Read in the gender inequality index data and the spatial data of the World
·Convert country codes from ISO3 to ISO2 format using the countrycode package.

2. Spatial Join:
Merge the GII data with geographic data.
   
3. Calculation:
Calculate the difference in inequality between 2010 and 2019, creating a new column.

4. Visualization:
Create a map to show the difference in gender inequality index across countries between 2010 and 2019.

## Results

The map shows the difference in gender inequality index between 2010 and 2019.
