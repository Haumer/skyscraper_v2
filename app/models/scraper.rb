class Scraper < ApplicationRecord
  require 'awesome_print'
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
  has_many :scraper_errors, dependent: :destroy

  def crawl(search)
    build_url(search.keyword, search.location).each_with_index do |url, i|
      begin
        Timeout::timeout(15) do
          page = Nokogiri::HTML(open(url))
          page.search(card_class).each do |result_card|
            if title_or_description_contains_keyword?(result_card, search.keyword)
              data = {
                website: website,
                job_website: website.base_url,
                search: search
              }.merge(extract_data(result_card))
              Job.create!(data)
            end
          end
        rescue Timeout::Error => e
          set_error(e, url, search)
        end
      rescue StandardError => e
        set_error(e, url, search)
      end
      sleep(0.5)
    end
    Scraper.most_recent
  end

  private

  def title_or_description_contains_keyword?(card, keyword)
    result_card.search(title_class).text.strip.downcase.include?(search.keyword) || result_card.search(description_class).text.strip.downcase.include?(search.keyword)
  end

  def set_error(e, url, search)
    puts e.message
    puts url
    ScraperError.create(message: e.message, url: url, keyword: search.keyword, location: search.location, scraper: self)
  end

  def extract_data(card)
    data = {}
    data[:title] = card.search(title_class).text.strip
    data[:link] = card.search(link_class).first['href']
    data[:location] = card.search(location_class).text.strip
    data[:company] = card.search(company_class).text.strip
    data[:description] = card.search(description_class).text.strip
    if card.search(salary_class).text.strip.nil? || card.search(salary_class).text.strip.empty?
      data[:salary] = "unspecified"
    else
      data[:salary] = card.search(salary_class).text.strip
    end
    return data
  end

  def build_url(keyword, location)
    url = scrape_url.gsub("KEYWORD", keyword).gsub("LOCATION", location)
    (counter_start...nr_pages).map do |count|
      url.gsub("COUNTER", "#{counter_interval * count}")
    end
  end

  def self.most_recent
    scrapers = {}
    Scraper.all.each do |scraper|
      if scraper.website.jobs.empty?
        scrapers[scraper.website.name] = ["has no jobs scraped", scraper.website.base_url]
      elsif (Search.last.created_at - 1.minute ) > scraper.website.jobs.last.created_at
        scrapers[scraper.website.name] = ["has no recent jobs scraped", scraper.website.base_url]
      else
        scrapers[scraper.website.name] = "last job was scraped on: #{scraper.website.jobs.last.created_at}"
      end
    end
    ap scrapers
  end
end
