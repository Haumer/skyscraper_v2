Website.destroy_all

websites = %w( www.cv-library.co.uk www.jobstoday.co.uk www.indeed.co.uk www.totaljobs.com www.reed.co.uk )

websites.each do |website|
  name = website.split(".")[1]
  Website.create!(url: website, name: name)
end

# Scraper.create!(
#   card_class: ".job-search-description",
#   title_class: "#js-jobtitle-details",
#   link_class: ".jobtitle-divider a",
#   location_class: "#js-loc-details",
#   company_class: ".agency-link-mobile",
#   salary_class: "#js-salary-details",
#   website: Website.first,
#   nr_pages: 3,
#   scrape_url: "https://www.cv-library.co.uk/search-jobs?distance=15&fp=1&geo=LOCATION&offset=COUNTER&posted=28&q=KEYWORD&salarymax=&salarymin=&salarytype=annum&search=1&tempperm=Any"
# )
