class Scraper < ApplicationRecord
  require 'open-uri'

  belongs_to :website

  def crawl(keyword, location)
    build_url(keyword, location).each do |url|
      page = Nokogiri::HTML(open(url))
      page.search("#{self.card_class}").each do |result_card|
        if result_card.search("#{self.title_class}").text.strip.downcase.include?(keyword)
          title = result_card.search("#{self.title_class}").text.strip
          link = self.website.name + result_card.search("#{self.link_class}").first['href']
          location = result_card.search("#{self.location_class}").text.strip
          company = result_card.search("#{self.company_class}").text.strip
          if result_card.search("#{self.salary_class}").text.strip.nil? || result_card.search("#{self.salary_class}").text.strip.empty?
            salary = nil
          else
            salary = result_card.search("#{self.salary_class}").text.strip
          end
          website = self.website.name
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
  end

  def build_url(keyword, location)
    url = self.scrape_url.gsub("KEYWORD", keyword).gsub("LOCATION", location)
    (0...self.nr_pages).map do |count|
      url.gsub("COUNTER", "#{self.counter_interval * count}")
    end
  end
end
