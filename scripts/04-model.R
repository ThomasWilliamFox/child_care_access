#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


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
  mutate(language = english / total) |>
  mutate(racialized = visible_minority / total)

merged_data$income

### Model data ####
first_model <-
  stan_glm(
    formula = prop ~ income + language + racialized,
    data = merged_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)
