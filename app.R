library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)
library(gapminder)

source('src/job_gender_employment_fig.R')
source('src/job_gender_group_fig.R')
source('src/top_10_job_fig.R')

app <- Dash$new(
  external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css"
)

first_graph <- dccGraph(
  id = 'employee-counts',
  figure = make_job_gender_employment_fig()
)

second_graph <- dccGraph(
  id = 'gender-dominant',
  figure = make_job_gender_group_fig()
)

third_graph <- dccGraph(
  id = 'top-10',
  figure = make_top_10_job_fig()
)

app$layout(
  htmlDiv(
    list(
      htmlH1('First attempt'),
      htmlH2('Stuff'),
      first_graph,
      htmlDiv(),
      second_graph,
      htmlDiv(),
      third_graph
    )
  )
)

app$run_server()
