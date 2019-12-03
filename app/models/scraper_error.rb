class ScraperError < ApplicationRecord
  belongs_to :scraper

  def self.one(website)
    self.where(scraper: website.scraper).order(created_at: :desc).first(50)
  end

  def self.general
    self.all.order(created_at: :desc).first(50)
  end
end
