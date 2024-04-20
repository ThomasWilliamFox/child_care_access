#### Preamble ####
# Purpose: Simulates Toronto ward and childcare data
# Author: Thomas Fox
# Date: 3 April 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: n/a
# Any other information needed? n/a


#### Workspace setup ####

library(tidyverse)
library(lintr)

# Run lintr, all major issues fixed, remaining issues are unclear or not helpful
lintr::lint("scripts/00-simulate_data.R")


#### Build simulated data ####

set.seed(456)

#### Simulate data ####

simulated_ward_data <-
  tibble(
    sim_ward = sample(
      x = c(1:25),
      size = 25,
      replace = FALSE),
    
    sim_children = sample(
      x = c(10000:25000),
      size = 25,
      replace = TRUE),
    
    sim_spaces = sample(
      x = c(3000:7000),
      size = 25,
      replace = TRUE),
  
    sim_income = sample(
      x = c(70000:200000),
      size = 25,
      replace = TRUE),
    
    sim_non_english = sample(
      x = c(20000:50000),
      size = 25,
      replace = TRUE),
    
    sim_total_population = sample(
      x = c(90000:110000),
      size = 25,
      replace = TRUE)
  )

# Arrange data by ward number
simulated_ward_data <-
  simulated_ward_data |>
  arrange(sim_ward)

#### Graph simulated data ####

# Average income by ward
simulated_ward_data |>
  ggplot(aes(x = factor(sim_ward), y = sim_income)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Ward", y = "Average household income")

# Child per space by ward
simulated_ward_data |>
  ggplot(aes(x = factor(sim_ward), y = sim_children / sim_spaces)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Ward", y = "Children per space")

# Proportion of non-English speakers by ward
simulated_ward_data |>
  ggplot(aes(x = factor(sim_ward), y = sim_non_english / sim_total_population * 
               100)) + 
  geom_bar(stat = "identity") + 
  theme_minimal() + 
  labs(x = "Ward", y = "Proportion of non-English speakers (%)") 

# Average household income and children per child care space by ward
simulated_ward_data |>
  ggplot(aes(x = sim_income, y = sim_children / sim_spaces)) +
  geom_point(fill = "black", size = 1, shape = 23) +
  geom_smooth(method = lm, color = "black") +
  theme_minimal() +
  labs(x = "Average household income in ward ($)", y = "Children per child care 
       space") 

# Non-English speaking population and children per child care space by ward
simulated_ward_data |>
  ggplot(aes(x = sim_non_english / sim_total_population * 100, y = sim_children 
             / sim_spaces)) +
  geom_point(fill = "black", size = 1, shape = 23) +
  geom_smooth(method = lm, color = "black") +
  theme_minimal() +
  labs(x = "Proportion of non-English speakers by ward  (%)", y = "Children per 
       child care space") 

#### Test simulated data ####

if (nrow(simulated_ward_data) != 25) {
  print("Number of wards is incorrect")
}

if (min(simulated_ward_data$sim_ward) <= 0) {
  print("Ward number column contains negative value")
}

if (max(simulated_ward_data$sim_ward) > 25) {
  print("Ward column contains value greater than 25")
}

if (min(simulated_ward_data$sim_children) < 10000) {
  print("Child population column contains value under lower limit")
}

if (max(simulated_ward_data$sim_children) > 25000) {
  print("Child population column contains value above upper limit")
}

if (min(simulated_ward_data$sim_spaces) < 3000) {
  print("Child care spaces column contains value under lower limit")
}

if (max(simulated_ward_data$sim_spaces) > 7000) {
  print("Child care spaces column contains value above upper limit")
}

if (min(simulated_ward_data$sim_income) < 70000) {
  print("Average household income column contains value under lower limit")
}

if (max(simulated_ward_data$sim_income) > 200000) {
  print("Average household income column contains value above upper limit")
}

if (min(simulated_ward_data$sim_non_english) < 20000) {
  print("Non enlgish speaking population column contains value under lower 
        limit")
}

if (max(simulated_ward_data$sim_non_english) > 50000) {
  print("Non enlgish speaking population column contains value above upper 
        limit")
}

if (min(simulated_ward_data$sim_total_population) < 90000) {
  print("Total population column contains value under lower limit")
}

if (max(simulated_ward_data$sim_total_population) > 110000) {
  print("Total population column contains value above upper limit")
}
