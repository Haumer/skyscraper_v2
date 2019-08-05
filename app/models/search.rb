class Search < ApplicationRecord
  has_many :jobs
  validates :keyword, presence: true
  validates :salary, presence: true
  validates :location, presence: true
  validates :link, presence: true
  validates :job_website, presence: true
end
