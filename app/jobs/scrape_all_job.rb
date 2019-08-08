class ScrapeAllJob < ApplicationJob
  queue_as :default

  after_perform :update_status

  def perform(search)
    @search = search
    Scraper.all.each do |scraper|
      scraper.crawl(search)
    end
  end

  private

  def update_status
    @search.update(status: true, status_message: "done")
  end
end
