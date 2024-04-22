# Inequitable Access

## Overview

This repo includes all files needed to reproduce the paper "Inequitable Access: An Analysis of Licensed Child Care in Toronto's 25 Wards". The paper examines the accessibility of licensed child care centres across Toronto's 25 wards. Findings indicate that there are more children per existing child care space in wards with lower household incomes, lower proportions of English speaking households, and higher proprotions of the population identifying as racialized. These findings suggest inequitable access to licensed child care spaces based on a variety of social factors, supporting initiatives aimed at increasing access to licensed child care in the city of Toronto."

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from opendatatoronto.
-   `data/analysis_data` contains the cleaned datasets that were constructed.
-   `model` contains fitted models. 
-   `other` contains sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Instructions

Run:

-   `scripts/00-simulate_data.R` to run simulations
-   `scripts/01-download_data.R` to download data 
-   `scripts/02-data_cleaning.R` to clean all relevant data for producing paper.
-   `scripts/03-test_data.R` to test clean data sets.
-   `scripts/04-model.R` to produce model. 

Run/Render:

-   `paper/child_care_access.qmd` to see how graphs/tables were created and render paper to PDF format

## Statement on LLM usage

LLMs were not used in the research, writing, or computational aspects of this paper. 
