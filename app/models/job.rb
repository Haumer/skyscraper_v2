class Job < ApplicationRecord
  belongs_to :search

  validates :title,  presence: true
  validates :salary, presence: true
  validates :location, presence: true
  validates :link, presence: true
  validates :job_website, presence: true
end
