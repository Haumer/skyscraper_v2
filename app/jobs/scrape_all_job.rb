class ScrapeAllJob < ApplicationJob
  queue_as :default

  def perform(search)
    Scraper.all.each do |scraper|
      scraper.crawl(search)
    end
  end
end
