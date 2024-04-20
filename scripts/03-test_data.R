#### Preamble ####
# Purpose: Tests cleaned data sets
# Author: Thomas Fox
# Date: 3 April 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: run 01-download_data.R and 02-data_cleaning.R
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(janitor)
library(lintr)
library(here)
library(arrow)

# Run lintr, all issues fixed
lintr::lint("scripts/03-test_data.R")

#### Load Cleaned Data Sets ####

# read child care data

child_care_test <- read_parquet(
  file = here("data/analysis_data/child_care_data.parquet"),
  show_col_types = FALSE
)

# read summarized child care data

summarized_child_care_test <- read_parquet(
  file = here("data/analysis_data/ward_child_care_data.parquet"),
  show_col_types = FALSE
)

# read census ward data

ward_data_test <- read_parquet(
  file = here("data/analysis_data/census_data.parquet"),
  show_col_types = FALSE
)

# read merged data

merged_ward_childcare_test <- read_parquet(
  file = here("data/analysis_data/merged_ward_data.parquet"),
  show_col_types = FALSE
)

# read names data

ward_names_test <- read_parquet(
  file = here("data/analysis_data/ward_names.parquet"),
  show_col_types = FALSE
)


# Test child care data

if (nrow(child_care_test) != 1066) {
  print("Size of child care data is incorrect ")
}

if (min(child_care_test$x_id) < 0) {
  print("Centre ID column contains negative value")
}

if (min(child_care_test$ward) < 0) {
  print("Ward column contains negative value")
}

if (max(child_care_test$ward) > 25) {
  print("Ward column contains number greater than 25")
}

if (min(child_care_test$totspace) < 0) {
  print("Total space column contains negative value")
}


# Test summarized child care data

if (nrow(summarized_child_care_test) > 25) {
  print("More than 25 wards in data")
}

if (min(summarized_child_care_test$ward) < 0) {
  print("Negative ward number")
}

if (max(summarized_child_care_test$ward) > 25) {
  print("Incorrect ward number")
}

if (min(summarized_child_care_test$total_spots) < 0) {
  print("Total spots column has negative value")
}

if (min(summarized_child_care_test$subsidy) < 0) {
  print("Subsidy column has negative value")
}


# Test ward data

if (nrow(ward_data_test) > 25) {
  print("More than 25 wards in data")
}

if (min(ward_data_test$ward) < 0) {
  print("Negative ward number")
}

if (max(ward_data_test$total) < max(ward_data_test$official)) {
  print("Language column contains value greater than total population")
}

if (max(ward_data_test$total) < max(ward_data_test$visible_minority)) {
  print("Racialized column contains value greater than total population ")
}

if (min(ward_data_test$avg_hh_income) < 0) {
  print("Average income column contains negative value")
}


# Test merged data

if (nrow(merged_ward_childcare_test) > 25) {
  print("More than 25 wards in data")
}

if (min(merged_ward_childcare_test$ward) < 0) {
  print("Negative ward number")
}

if (max(merged_ward_childcare_test$total) < max(merged_ward_childcare_test$
                                                  official)) {
  print("Language column contains value greater than total population")
}

if (max(merged_ward_childcare_test$total) < max(merged_ward_childcare_test$
                                                  visible_minority)) {
  print("Racialized column contains value greater than total population ")
}

if (min(merged_ward_childcare_test$avg_hh_income) < 0) {
  print("Average income column contains negative value")
}

if (min(merged_ward_childcare_test$prop) < 0) {
  print("Negative value in children per spot column")
}

if (max(merged_ward_childcare$total_under_15) > max(merged_ward_childcare_test
                                                    $total)) {
  print("Total under 15 column has value greater than total population")
}

if (min(merged_ward_childcare_test$total_spots) < 0) {
  print("Total child care spots column contains negative value")
}


# Test names data

if (nrow(ward_names_test) != 25) {
  print("Incorrect number of wards in data")
}

if (max(ward_names_test$ward_number) > 25) {
  print("Incorrect ward number")
}

if (min(ward_names_test$ward_number) < 0) {
  print("Ward number column contains negative number")
}

if (!is.numeric(ward_names_test$ward_number)) {
  print("Ward number column is not a numeric value")
}

if (!is.character(ward_names_test$ward_name)) {
  print("Ward name column is not character class")
}
