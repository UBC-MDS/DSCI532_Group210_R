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
data2 <- read.csv('data/wrangling_for_r_figure_2.csv')
f2 <- data2 %>% 
    ggplot(aes(year, total, color = job_gender_dominant_group)) + 
    geom_line() +
    labs(title = "Number of Job Gender Dominant Groups by Year", x = "Year", y = 'Number of Jobs', color = 'Job Gender Dominant Group') +
    theme_bw()
graph2 <- dccGraph(
  id = 'gender-dominant',
  figure=ggplotly(f2)
)

#define 3rd figure
data3 <- read.csv('data/top_10_male_jobs.csv')
f3 <- data3 %>% 
    ggplot(aes(year, female_prop, color = job)) + 
    geom_line() +
    scale_y_continuous(labels=scales::percent) +
    labs(title = 'Proportion of Women by Year', x = 'Year', y = 'Proportion of Women', color = 'Job') +
    theme_bw()
graph3 <- dccGraph(
  id = 'top-10',
  figure=ggplotly(f3)
)

app$layout(
  htmlDiv(
    list(
      htmlH1('First attempt'),
      htmlH2('????'),
      graph2,
      htmlDiv(),
      graph3, #spacer
      dccMarkdown("[Data Source](https://cran.r-project.org/web/packages/gapminder/README.html)")
    )
  )
)

app$run_server()

### App created by Kate Sedivy-Haley as part of the DSCI 532 Teaching Team