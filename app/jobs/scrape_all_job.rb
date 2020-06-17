class ScrapeAllJob < ApplicationJob
  queue_as :default
  after_perform :update_status_scrape

  def perform(id)
    @search = Search.find(id)
    Scraper.all.each do |scraper|
      scraper.crawl(@search)
    end
  end

  private

  def update_status_scrape
    @search.update(status_scraped: true, status_message: "finished scraping")
    puts "Formatting..."
    FormattingJob.perform_later(@search.id)
    puts "done!"
    puts "Removing duplicates..."
    RemoveDuplicatesJob.perform_later(@search.id)
    puts "done!"
  end
end
