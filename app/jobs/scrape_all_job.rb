class ScrapeAllJob < ApplicationJob
  queue_as :default
  after_perform :update_status_scrape

  def perform(search)
    @search = search
    Scraper.all.each do |scraper|
      scraper.crawl(search)
    end
  end

  private

  def update_status_scrape
    @search.update(status_scraped: true, status_message: "finished scraping")
    FormattingJob.perform_later(@search)
  end
end
