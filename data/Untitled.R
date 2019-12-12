library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

data_map <- list(
  top_10_male = read_csv('data/top_10_male_jobs.csv', col_names = 1),
  top_10_female = read_csv('data/top_10_female_jobs.csv', row.names = 1),
  top_10_balanced = read_csv('data/top_10_balanced_jobs.csv', row.names = 1)
)

data_map['top_10_male']
