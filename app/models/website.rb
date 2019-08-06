class Website < ApplicationRecord
  validates :url, presence: true
  validates :name, presence: true

  has_one :scraper
end
