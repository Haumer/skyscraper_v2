Website.destroy_all
Scraper.destroy_all

websites = %w( www.cv-library.co.uk www.jobstoday.co.uk www.indeed.co.uk www.totaljobs.com www.reed.co.uk )

websites.each do |website|
  name = website.split(".")[1]
  Website.create!(base_url: website, name: name)
end

Scraper.create!(
  card_class: ".job-search-description",
  title_class: "#js-jobtitle-details",
  link_class: ".jobtitle-divider a",
  location_class: "#js-loc-details",
  company_class: ".agency-link-mobile",
  salary_class: "#js-salary-details",
  website: Website.where(base_url: "www.cv-library.co.uk").first,
  counter_interval: 25,
  nr_pages: 3,
  scrape_url: "https://www.cv-library.co.uk/search-jobs?distance=15&fp=1&geo=LOCATION&offset=COUNTER&posted=28&q=KEYWORD&salarymax=&salarymin=&salarytype=annum&search=1&tempperm=Any"
)

Scraper.create!(
  card_class: ".lister__item--networkjob",
  title_class: "h3",
  link_class: "a",
  location_class: ".lister__meta-item--location",
  company_class: ".lister__meta-item--recruiter",
  salary_class: ".lister__meta-item--salary",
  website: Website.where(base_url: "www.jobstoday.co.uk").first,
  counter_interval: 1,
  nr_pages: 3,
  scrape_url: "https://www.jobstoday.co.uk/searchjobs/?LocationId=1500&keywords=KEYWORD&radiallocation=10&countrycode=GB&Page=COUNTER&sort=Relevance"
)
# location has unique id. look into this later

Scraper.create!(
  card_class: ".result",
  title_class: ".jobtitle",
  link_class: "a",
  location_class: ".location",
  company_class: ".company",
  salary_class: ".no-wrap",
  website: Website.where(base_url: "www.indeed.co.uk").first,
  counter_interval: 1,
  nr_pages: 3,
  scrape_url: "https://www.indeed.co.uk/jobs?q=KEYWORD&l=LOCATION&start=COUTNER"
)
