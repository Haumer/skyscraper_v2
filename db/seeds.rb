Website.destroy_all

websites = %w( www.cv-library.co.uk www.jobstoday.co.uk www.indeed.co.uk www.totaljobs.com www.reed.co.uk )

websites.each do |website|
  name = website.split(".")[1]
  Website.create!(url: website, name: name)
end

