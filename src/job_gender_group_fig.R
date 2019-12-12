library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

gender_group_data <- read_csv('data/job_gender_group.csv')

make_job_gender_group_fig <- function () {
  f2 <- gender_group_data %>%
    ggplot(aes(year, total, color = job_gender_dominant_group)) +
    geom_line() +
    labs(
      title = "Number of Job Gender Dominant Groups by Year",
      x = "Year",
      y = 'Number of Jobs',
      color = 'Job Gender Dominant Group'
    ) +
    theme_bw()

  ggplotly(f2)
}
