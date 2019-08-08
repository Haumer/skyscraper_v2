class Scraper < ApplicationRecord
  require 'open-uri'

  validates :scrape_url, presence: true, uniqueness: true
  validates :nr_pages, presence: true, numericality: true
  validates :card_class, presence: true
  validates :title_class, presence: true
  validates :link_class, presence: true
  validates :location_class, presence: true
  validates :company_class, presence: true
  validates :salary_class, presence: true
  validates :description_class, presence: true
  belongs_to :website

  def crawl(search)
    build_url(search.keyword, search.location).each_with_index do |url, i|
      begin
        page = Nokogiri::HTML(open(url))
        page.search(self.card_class).each do |result_card|
          if result_card.search(self.title_class).text.strip.downcase.include?(search.keyword) || result_card.search(self.description_class).text.strip.downcase.include?(search.keyword)
            title = result_card.search(self.title_class).text.strip
            link = result_card.search(self.link_class).first['href']
            location = result_card.search(self.location_class).text.strip
            company = result_card.search(self.company_class).text.strip
            description = result_card.search(self.description_class).text.strip
            if result_card.search(self.salary_class).text.strip.nil? || result_card.search(self.salary_class).text.strip.empty?
              salary = "unspecified"
            else
              salary = result_card.search(self.salary_class).text.strip
            end
            website = self.website.base_url
            Job.create!(
              title: title,
              location: location,
              job_website: website,
              description: description,
              website: self.website,
              salary: salary,
              company: company,
              link: link,
              search: search
            )
          end
        end
      rescue StandardError => e
        puts e.message
        puts url
        return
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
