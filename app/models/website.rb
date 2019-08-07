class Website < ApplicationRecord
  validates :base_url, presence: true
  validates :name, presence: true

  has_one :scraper, dependent: :destroy
end
