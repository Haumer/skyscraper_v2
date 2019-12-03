class Job < ApplicationRecord
  belongs_to :search
  belongs_to :website

  validates :title,  presence: true
  validates :salary, presence: true
  validates :location, presence: true
  validates :link, presence: true
  validates :job_website, presence: true
  validates :quality, presence: true

end
