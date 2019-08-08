class Website < ApplicationRecord
  require "awesome_print"
  validates :base_url, presence: true
  validates :name, presence: true

  has_one :scraper, dependent: :destroy
  has_many :jobs, dependent: :destroy

  def self.all_scrapers
    ap Scraper.all.map { |scraper| scraper.scrape_url }
  end
end
