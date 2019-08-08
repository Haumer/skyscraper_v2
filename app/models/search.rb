class Search < ApplicationRecord
  after_create :find_jobs

  has_many :jobs, dependent: :destroy
  belongs_to :user
  validates :keyword, presence: true
  validates :location, presence: true

  def find_jobs
    ScrapeAllJob.perform_later(self)
  end
end
