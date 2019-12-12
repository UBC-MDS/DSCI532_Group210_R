#Let's start over using the gapminder data set!

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)
library(gapminder)

# We'll replace our styles with an external stylesheet 
# for simplicity
app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

#define 2nd figure
data <- read.csv('data/wrangling_for_r_figure_2.csv')
f2 <- data %>% 
    ggplot(aes(year, total, color = job_gender_dominant_group)) + 
    geom_line() +
    labs(title = "Number of Job Gender Dominant Groups by Year", x = "Year", y = 'Number of Jobs', color = 'Job Gender Dominant Group') +
    theme_bw()



graph <- dccGraph(
  id = 'gender-dominant',
  figure=ggplotly(f2)
)

app$layout(
  htmlDiv(
    list(
      htmlH1('Gapminder Dash Demo'),
      htmlH2('Looking at country data interactively'),
      graph,
      htmlDiv(), #spacer
      dccMarkdown("[Data Source](https://cran.r-project.org/web/packages/gapminder/README.html)")
    )
  )
)

app$run_server()

### App created by Kate Sedivy-Haley as part of the DSCI 532 Teaching Team