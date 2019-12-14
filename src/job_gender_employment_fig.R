job_gender_data <- read_csv('data/jobs_original.csv')

jobsDropdownId <- 'jobs-dropdown'
uniqueJobs <- unique(job_gender_data$job)

jobsDropdown <- dccDropdown(
  id = jobsDropdownId,
  options = map(
    1:length(uniqueJobs),
    function(i) {
      list(
        label=uniqueJobs[i],
        value=uniqueJobs[i]
      )
    }
  ),
  value = 'Advertising Agent'
)

make_job_gender_employment_fig <- function (
  selected_job = 'Advertising Agent'
) {
  data_by_job <- job_gender_data %>% filter(job == selected_job)

  fig <- ggplot(data_by_job, aes(year, count, color = sex)) +
    geom_line() +
    scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
    labs(
      title = paste("Number of Employees by Year for", selected_job),
      x= "Year",
      y= "Number of Employees"
    ) +
    theme_bw()
  
  ggplotly(fig)
}
