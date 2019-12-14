library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

source('./src/job_gender_employment_fig.R')
source('./src/job_gender_group_fig.R')
source('./src/top_10_job_fig.R')
source('./src/header.R')
source('./src/footer.R')

app <- Dash$new(
  external_stylesheets = c(
    'https://codepen.io/chriddyp/pen/bWLwgP.css',
    'https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css'
  )
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

divider <- htmlDiv(className='border-bottom mb-5 mt-5')

app$layout(
  htmlDiv(
    list(
      header,
      htmlP("
          Let's first look at the male and female employment trends of
          individual jobs.
      ", className='lead mb-4 font-weight-bold'),
      htmlP("
        Toggle the sex groups to filter
      ", className='lead mb-0'),
      htmlDiv(list(
        htmlDiv(list(
          htmlLabel('Select a job'),
          jobsDropdown
        ), className='column side', style=list(width = '15%')),
        htmlDiv(
          list(first_graph),
          className='column middle',
          style=list(marginLeft = 0)
        )
      ), className='row'),
      divider,
      htmlP(list(
        "
          Here, we will categorize the jobs into different gender dominant
          groups, based on their gender ratios, and look at their trends
          over the decades.
        ",
        htmlBr(),
        "
          Dominance is categorized by having more than two to
          one for a gender ratio.
        "
      ), className='lead mb-4 font-weight-bold'),
      htmlP("
        Toggle the gender groups to filter
      ", className='lead mb-0'),
      htmlDiv(list(
        htmlDiv(
          list(second_graph),
          className='column middle'
        )
      ), className='row'),
      divider,
      htmlP("
          For the final graph, we will look at different top 10 jobs in terms of
          their historical female employment proportion and investigate how their
          gender balance has changed over time.
      ", className='lead mb-4 font-weight-bold'),
      htmlP("
        Toggle the jobs to filter
      ", className='lead mb-0'),
      htmlDiv(list(
        htmlDiv(list(
          htmlLabel('Select a gender balance'),
          top_10_category_dropdown
        ), className='column side', style=list(width = '15%')),
        htmlDiv(
          list(third_graph),
          className='column middle',
          style=list(marginLeft = 0)
        )
      ), className='row'),
      footer
    ),
    className = 'container main'
  )
)

app$callback(
  output=list(id = 'employee-counts', property='figure'),
  params=list(input(id = jobsDropdownId, property='value')),
  function(selected_job) {
    make_job_gender_employment_fig(selected_job)
  }
)

app$callback(
  output=list(id='top-10', property='figure'),
  params=list(input(id=top_10_category_dropdown_id, property='value')),
  function(top_10_category) {
    make_top_10_job_fig(top_10_category)
  }
)

app$run_server(host = "0.0.0.0", port = Sys.getenv('PORT', 8050))
