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
      p url
      begin
        Timeout::timeout(1995) do
          page = Nokogiri::HTML(open(url))
          page.search(card_class).each do |result_card|
            p result_card.text
            if title_or_description_contains_keyword?(result_card, search.keyword)
              data = {
                website: website,
                job_website: website.base_url,
              }.merge(extract_data(result_card))
              create_or_find_job(data, search)
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

  def create_or_find_job(data, search)
    # FIXME: (haumer) optimise with find_or_create_by
    job = Job.find_by(link: data[:link])
    job = job ? job : Job.create!(data)
    SearchJob.create!(job: job, search: search)
  end

  def extract_data(card)
    {
      title: card.search(title_class).text.strip,
      link: card.search(link_class).first['href'],
      location: card.search(location_class).text.strip,
      company: card.search(company_class).text.strip,
      description: card.search(description_class).text.strip,
      salary: set_salary(card)
    }
  end

  def build_url(keyword, location)
    url = scrape_url.gsub("KEYWORD", keyword).gsub("LOCATION", location)
    (counter_start...nr_pages).map do |count|
      url.gsub("COUNTER", "#{counter_interval * count}")
    end
  end

  def self.most_recent
    # FIXME: (haumer) maybe refactor this?
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

  def set_salary(card)
    salary_is_nil_or_empty?(card) ? "unspecified" : card.search(salary_class).text.strip
  end

  def set_error(e, url, search)
    puts e.message
    puts url
    ScraperError.create(message: e.message, url: url, keyword: search.keyword, location: search.location, scraper: self)
  end

  def title_or_description_contains_keyword?(card, keyword)
    card.search(title_class).text.strip.downcase.include?(keyword) || card.search(description_class).text.strip.downcase.include?(keyword)
  end

  def salary_is_nil_or_empty?(card)
    card.search(salary_class).text.strip.nil? || card.search(salary_class).text.strip.empty?
  end
end
