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

child_care_test


# Test summarized child care data

summarized_child_care_test


# Test ward data

ward_data_test


# Test merged data

merged_ward_childcare_test


# Test names data

ward_names_test
