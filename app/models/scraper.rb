class Scraper < ApplicationRecord
  require 'open-uri'

  belongs_to :website

  def crawl(**args)
    @@url = "https://www.cv-library.co.uk/search-jobs?distance=15&fp=1&geo=london&offset=0&posted=28&q=ruby&salarymax=&salarymin=&salarytype=annum&search=1&tempperm=Any"
    page = Nokogiri::HTML(open(@@url))
    page.search("#{args[:card_class]}").each do |result_card|
      if result_card.search("#{args[:title_class]}").text.strip.downcase.include?("#{args[:keyword]}")
        title = result_card.search("#{args[:title_class]}").text.strip
        link = "#{args[:name]}" + result_card.search("#{args[:link_class]}").first['href']
        location = result_card.search("#{args[:location_class]}").text.strip
        company = result_card.search("#{args[:company_class]}").text.strip
        if result_card.search("#{args[:salary_class]}").text.strip.nil? || result_card.search("#{args[:salary_class]}").text.strip.empty?
          salary = nil
        else
          salary = result_card.search("#{args[:salary_class]}").text.strip
        end
        website = "#{args[:name]}"
        Job.create!(
          title: title,
          location: location,
          job_website: website,
          salary: salary,
          company: company,
          link: link,
        )
      end
    end
  end

  def build_url()

  end
end
