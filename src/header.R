header <- htmlDiv(list(
  htmlDiv(list(
    htmlH1(list(
        htmlImg(src='/assets/job.png', className='logo'),
        'Job Analysis'
    )),
    htmlP("
      We are exploring a dataset of 255 jobs with both genders' employment
      numbers from 1850 to 2000 for each decade. We will focus on how
      the gender compositions in these jobs have evolved. An user might
      use this dashboard to gain insights with these trends and
      investigate how to improve gender balance in certain industries
      or jobs.
    ", className='lead my-3')
  ), className='col-md-9 px-0')
), className="jumbotron p-4 p-md-5 text-white rounded bg-dark")
