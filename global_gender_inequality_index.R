#install and load packages
library(sf)
library(here)
library(tidyverse)
library(dplyr)
library(stringr)
library(countrycode)
library(tmap)
library(usethis)

#Task1: Read in global gender inequality data

#step1: read the “All composite indices and components time series (1990-2022)” dataset
Alldataset<-read_csv(here::here("HDR23-24_Composite_indices_complete_time_series.csv"))
#view the data
Alldataset

#step2: select the columns that contain data about global gender inequality index
gender_inequality_index<-Alldataset%>%
  dplyr::select(contains("iso3"),
                contains("country"),
                contains("gii"))
#view the data
head(gender_inequality_index)

#Task2: Join the global gender inequality index to spatial data of the World

#step3: read the spatial data of the World
WorldSD<-st_read(here::here("World_Countries_(Generalized)_9029012925078512962.geojson"))
#get a summary of the data held within the file
summary(WorldSD)

#step4: filter out non-country data from gender inequality index
gender_inequality_index<-gender_inequality_index%>%
  filter(!str_detect(iso3,"ZZ"))
#view the data
head(gender_inequality_index)

#step5: convert country codes of 'gender_inequality_index' from ISO3 to ISO2
gender_inequality_index$ISO<-countrycode(gender_inequality_index$iso3, origin = 'iso3c', destination = 'iso2c')

#step6: join the .csv to the .geojson
JoinGii<-WorldSD%>%
  merge(.,
        gender_inequality_index,
        by.x= "ISO",
        by.y= "ISO")
#check the merge was successful
JoinGii%>%
  head(.,n=10)

#Task3: creating a new column of difference in inequality between 2010 and 2019

#step7: create a new column with the difference in inequality between 2010 and 2019
JoinGii<-JoinGii%>%
  mutate(gii_diff_2010_2019 = gii_2019 - gii_2010)
#view the data
print(JoinGii)

#step8: create a map
tmap_mode("plot")
tm_shape(JoinGii) +
  tm_polygons("gii_diff_2010_2019", 
              style = "pretty",
              palette = "-RdYlBu",
              midpoint = NA,
              title = "Difference") +
  tm_layout(main.title = "The Difference in Gender Inequality between 2010 and 2019",
            main.title.size = 1,
            legend.title.size = 0.6,
            legend.text.size = 0.35,
            legend.position = c("left", "bottom"))

#Task4: Share it with the World on GitHub
use_readme_md()
use_git()
use_github()
