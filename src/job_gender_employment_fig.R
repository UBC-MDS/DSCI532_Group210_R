library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

job_gender_data <- read_csv('data/jobs_original.csv')

make_job_gender_employment_fig <- function (
  selected_job = 'Advertising Agent'
) {
  data_by_job <- job_gender_data %>% filter(job == 'Advertising Agent')

  fig <- ggplot(data_by_job, aes(year, count, color = sex)) +
    geom_line() +
    scale_y_continuous(
      breaks=c(0, 20000, 40000, 60000, 80000, 100000, 120000, 140000),
      labels=c("0K", "20K", "40K", "60K", "80K", "100K", "120K", "140K")
    ) +
    labs(
      title = "Number of Employees by Year",
      x= "Year",
      y= "Number of Employees"
    ) +
    theme_bw()

  ggplotly(fig)
}
