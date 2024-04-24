#### Preamble ####
# Purpose: Models the effect of average household income on child care spaces
# Author: Thomas Fox
# Date: 23 April 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 01-download_data.R and 02-data_cleaning.R
# Any other information needed? n/a


#### Workspace setup ####
library(arrow)
library(tidyverse)
library(rstanarm)
library(lintr)

# Run lintr, all issues fixed
lintr::lint("scripts/04-model.R")

#### Read data ####
merged_data <- read_parquet("data/analysis_data/merged_ward_data.parquet")
merged_data <- merged_data |>
  mutate(income = avg_hh_income / max(avg_hh_income)) |>
  mutate(nonracialized = (total - visible_minority) / total) |>
  mutate(language = english / total)

### Model data ####
income_spaces_model <-
  stan_glm(
    formula = prop ~ income,
    data = merged_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 227
  )

#### Save model ####
saveRDS(
  income_spaces_model,
  file = "models/income_spaces_model.rds"
)
