Website.destroy_all
Scraper.destroy_all

websites = %w( www.cv-library.co.uk www.jobstoday.co.uk www.indeed.co.uk www.totaljobs.com www.reed.co.uk )

websites.each do |website|
  name = website.split(".")[1]
  Website.create!(base_url: website, name: name)
end

# CV-LIBRARY
Scraper.create!(
  card_class: ".job-search-description",
  title_class: "#js-jobtitle-details",
  link_class: ".jobtitle-divider a",
  location_class: "#js-loc-details",
  company_class: ".agency-link-mobile",
  salary_class: "#js-salary-details",
  description_class: ".job-search-details-description.search-result-desc.show-desc",
  website: Website.where(base_url: "www.cv-library.co.uk").first,
  counter_interval: 25,
  counter_start: 0,
  nr_pages: 3,
  scrape_url: "https://www.cv-library.co.uk/search-jobs?distance=15&fp=1&geo=LOCATION&offset=COUNTER&posted=28&q=KEYWORD&salarymax=&salarymin=&salarytype=annum&search=1&tempperm=Any"
)

# JOBSTODAY
Scraper.create!(
  card_class: ".lister__item--networkjob",
  title_class: "h3",
  link_class: "a",
  location_class: ".lister__meta-item--location",
  company_class: ".lister__meta-item--recruiter",
  salary_class: ".lister__meta-item--salary",
  description_class: ".lister__description .js-clamp-2",
  website: Website.where(base_url: "www.jobstoday.co.uk").first,
  counter_interval: 1,
  counter_start: 0,
  nr_pages: 3,
  scrape_url: "https://www.jobstoday.co.uk/searchjobs/?LocationId=1500&keywords=KEYWORD&radiallocation=10&countrycode=GB&Page=COUNTER&sort=Relevance"
)
# location has unique id. look into this later

# INDEED
Scraper.create!(
  card_class: ".result",
  title_class: ".jobtitle",
  link_class: "a",
  location_class: ".location",
  company_class: ".company",
  salary_class: ".no-wrap",
  description_class: ".summary",
  website: Website.where(base_url: "www.indeed.co.uk").first,
  counter_interval: 1,
  counter_start: 0,
  nr_pages: 3,
  scrape_url: "https://www.indeed.co.uk/jobs?q=KEYWORD&l=LOCATION&start=COUTNER"
)

# REED
Scraper.create!(
  card_class: ".job-result",
  title_class: "h3.title",
  link_class: "a",
  location_class: ".location",
  company_class: ".gtmJobListingPostedBy",
  salary_class: ".salary",
  description_class: ".description p",
  website: Website.where(base_url: "www.reed.co.uk").first,
  counter_interval: 1,
  counter_start: 1,
  nr_pages: 3,
  scrape_url: "https://www.reed.co.uk/jobs/jobs-in-LOCATION?keywords=KEYWORD&cached=True&pageno=COUNTER"
)
