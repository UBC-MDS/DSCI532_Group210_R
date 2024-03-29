library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

data_map <- list(
  top_10_male = read_csv('data/top_10_male_jobs.csv'),
  top_10_female = read_csv('data/top_10_female_jobs.csv'),
  top_10_balanced = read_csv('data/top_10_balanced_jobs.csv')
)

label_map <- list(
  top_10_male = "Male",
  top_10_female = "Female",
  top_10_balanced = "Balanced"
)

top_10_category_key <- tibble(
  label = c("Female Dominated", "Balanced", "Male Dominated"),
  value = c("top_10_female", "top_10_balanced", "top_10_male")
)

top_10_category_dropdown_id <- "top-10-category-dropdown"

top_10_category_dropdown <- dccDropdown(
  id = top_10_category_dropdown_id,
  options = map(
    1:nrow(top_10_category_key),
    function(i) {
      list(
        label=top_10_category_key$label[i],
        value=top_10_category_key$value[i]
      )
    }
  ),
  value = "top_10_female"
)

make_top_10_job_fig <- function (data_key = 'top_10_female') {
  jobs_woman_trend_fig <- ggplot(
    data_map[[data_key]],
    aes(year, female_prop, color = job)
  ) +
    geom_line() +
    scale_y_continuous(labels=scales::percent) +
    labs(
      title = 'Percentage of Women by Year',
      x = 'Year',
      y = 'Percentage of Women',
      color = ''
    ) +
    theme_bw()

  top_10_job_fig <- ggplot(
    data_map[[data_key]],
    aes(
      reorder(job, total_prop_female),
      total_prop_female,
      fill = job
    )
  ) +
    geom_col(position = 'dodge') +
    scale_y_continuous(labels=scales::percent) +
    coord_flip() +
    labs(
      title = paste(
        'Top 10',
        label_map[[data_key]],
        'Dominated Jobs by Percentage of Women (Annual and Total)'
      ),
      x = 'Job',
      y = "Percentage of Women",
      fill = 'Job'
    )+
    theme_bw()

  plots <- list(
    ggplotly(jobs_woman_trend_fig),
    ggplotly(top_10_job_fig, tooltip=c("job", "total_prop_female"))
  )

  subplot(plots, margin = 0.1)
}
