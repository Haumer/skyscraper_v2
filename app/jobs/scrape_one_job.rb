class ScrapeOneJob < ApplicationJob
  queue_as :default

  def perform(search, scraper)
    scraper.crawl(search)
  end
end
