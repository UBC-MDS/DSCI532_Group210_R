#Let's start over using the gapminder data set!

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)
library(gapminder)


app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

#define 1st figure
make_figure1 <- function(){
data1 <- read.csv('data/jobs_original.csv')
data_specific_placeholder <- data1 %>% filter(job == 'Advertising Agent')
f1 <- ggplot(data_specific_placeholder, aes(year, count, color = sex)) + 
     geom_line() + 
     scale_y_continuous(breaks=c(0,20000,40000,60000,80000, 100000, 120000, 140000), 
                        labels=c("0K", "20K", "40K", "60K", "80K", "100K", "120K", "140K"))+
     labs(title = "Number of Employees by Year", x= "Year", y= "Number of Employees")+
    theme_bw()
ggplotly(f1)
}
graph1 <- dccGraph(
  id = 'employee-counts',
  figure = make_figure1()
)

#define 2nd figure
make_figure2 <- function(){
data2 <- read.csv('data/wrangling_for_r_figure_2.csv')
f2 <- data2 %>% 
    ggplot(aes(year, total, color = job_gender_dominant_group)) + 
    geom_line() +
    labs(title = "Number of Job Gender Dominant Groups by Year", x = "Year", y = 'Number of Jobs', color = 'Job Gender Dominant Group') +
    theme_bw()
ggplotly(f2)
}
graph2 <- dccGraph(
  id = 'gender-dominant',
  figure = make_figure2()
)

#define 3rd figure
make_figure3 <- function(){
data3 <- read.csv('data/top_10_male_jobs.csv')
f3_1 <- ggplot(data3, aes(year, female_prop, color = job)) + 
    geom_line() +
    scale_y_continuous(labels=scales::percent) +
    labs(title = 'Proportion of Women by Year', x = 'Year', y = 'Proportion of Women', color = 'Job') +
    theme_bw()
f3_2 <- ggplot(data3, aes(job, total_prop_female, fill = job)) + 
    geom_bar(stat="identity") +
    scale_y_continuous(labels=scales::percent) +
    coord_flip() +
    labs(title = 'Jobs by Proportion of Women(10 Most Male Dominant)', y = "Proportion of Women", fill = 'Job')+
    theme_bw()
plots <- list(ggplotly(f3_1),ggplotly(f3_2))
subplot(plots)
}
graph3 <- dccGraph(
  id = 'top-10',
  figure = make_figure3()
)



app$layout(
  htmlDiv(
    list(
      htmlH1('First attempt'),
      htmlH2('Stuff'),
      graph1,
      htmlDiv(),
      graph2,
      htmlDiv(),
      graph3
    )
  )
)

app$run_server()

### App created by Kate Sedivy-Haley as part of the DSCI 532 Teaching Team