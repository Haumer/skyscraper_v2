class ScraperError < ApplicationRecord
  belongs_to :scraper

  private

  def self.one(website)
    self.where(scraper: website.scraper).order(created_at: :desc)
  end

  def self.general
    self.all.order(created_at: :desc)
  end
end
