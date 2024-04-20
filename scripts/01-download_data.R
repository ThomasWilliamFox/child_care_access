#### Preamble ####
# Purpose: Downloads and saves childcare and census data from opendatatoronto
# Author: Thomas Fox
# Date: 28 March 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: n/a
# Any other information needed? n/a

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)
library(lintr)

# Run lintr, all issues fixed
lintr::lint("scripts/01-download_data.R")


#### Download data ####

# Download Licensed Child Care data set from opendatatoronto
# Follows directions in "For Developers" section

# get package
package <- show_package("059d37c6-d88b-42fb-b230-ec6a5ec74c24")
package

# get all resources for this package
resources <- list_package_resources("059d37c6-d88b-42fb-b230-ec6a5ec74c24")

# identify datastore resources; by default, Toronto Open Data sets datastore
# resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c("csv"))

# load the first datastore resource as a sample
raw_childcare_data <- filter(datastore_resources, row_number() == 1) %>%
  get_resource()
raw_childcare_data


# Download Ward Profiles (25-Ward Model) data set from opndatatoronto

package_ward_profiles <-
  list_package_resources("6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb")
package_ward_profiles

# Census data including population and average household income
census_data <- get_resource("16a31e1d-b4d9-4cf0-b5b3-2e3937cb4121")
raw_census_data <- census_data[[1]]

# Ward names and corresponding numbers data
raw_ward_names <- get_resource("ea4cc466-bd4d-40c6-a616-7abfa9d7398f")

#### Save data ####

# Write raw child care data to data inputs folder
write_csv(raw_childcare_data, "data/raw_data/raw_childcare_data.csv")

# Write raw census data to data inputs folder
write_csv(raw_census_data, "data/raw_data/raw_census_data.csv")

# Write raw ward names and numbers to data inputs folder
write_csv(raw_ward_names, "data/raw_data/raw_ward_names.csv")
