class Search < ApplicationRecord
  has_many :jobs
  belongs_to :user
  validates :keyword, presence: true
  validates :salary, presence: true
  validates :location, presence: true
  validates :link, presence: true
  validates :job_website, presence: true
end
