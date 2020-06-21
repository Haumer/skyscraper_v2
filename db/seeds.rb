# TODO: dont run in production
if Rails.env.development?
  Website.destroy_all
  Scraper.destroy_all
  user = User.create!(email: "default@skyscraper.com", password: "123456", admin: true)
  Search.create!(keyword: "ruby", location: "london", user: user)
end

websites = %w( www.cv-library.co.uk www.jobstoday.co.uk www.indeed.co.uk www.totaljobs.com www.reed.co.uk www.jobsite.co.uk)

websites.each { |website| Website.create!(base_url: website, name: website.split(".")[1]) }

# CV-LIBRARY
Scraper.create!(
  card_class: ".results__item",
  title_class: ".job__title",
  link_class: ".job__title a",
  location_class: ".job__details-location",
  company_class: ".company + dd a",
  salary_class: "dd.salary",
  description_class: ".job__description.noscript-show",
  website: Website.find_by(base_url: "www.cv-library.co.uk"),
  counter_interval: 100,
  counter_start: 0,
  nr_pages: 3,
  scrape_url: "https://www.cv-library.co.uk/search-jobs?distance=15&fp=1&geo=LOCATION&offset=COUNTER&perpage=100&posted=28&q=KEYWORD&salarymax=&salarymin=&salarytype=annum&search=1&tempperm=Any"
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
  website: Website.find_by(base_url: "www.jobstoday.co.uk"),
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
  website: Website.find_by(base_url: "www.indeed.co.uk"),
  counter_interval: 1,
  counter_start: 0,
  nr_pages: 3,
  scrape_url: "https://www.indeed.co.uk/jobs?q=KEYWORD&l=LOCATION&start=COUNTER"
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
  website: Website.find_by(base_url: "www.reed.co.uk"),
  counter_interval: 1,
  counter_start: 1,
  nr_pages: 3,
  scrape_url: "https://www.reed.co.uk/jobs/jobs-in-LOCATION?keywords=KEYWORD&cached=True&pageno=COUNTER"
)

# JOBSITE
Scraper.create!(
  card_class: ".job",
  title_class: "h2",
  link_class: "a",
  location_class: ".location",
  company_class: ".company",
  salary_class: ".salary",
  description_class: ".job-intro",
  website: Website.find_by(base_url: "www.jobsite.co.uk"),
  counter_interval: 1,
  counter_start: 1,
  nr_pages: 3,
  scrape_url: "https://www.jobsite.co.uk/jobs/KEYWORD/in-LOCATION?radius=10"
  # FIXME: (haumer) currently &page times out
  # scrape_url: "https://www.jobsite.co.uk/jobs/KEYWORD/in-LOCATION?radius=10&page=COUNTER"
)
