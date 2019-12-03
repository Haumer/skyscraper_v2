class Search < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :websites, -> { distinct }, through: :jobs
  belongs_to :user
  validates :keyword, presence: true
  validates :location, presence: true

  def top_jobs
    jobs.select { |job| job.quality >= 4 }
  end

  def low_jobs
    jobs.select { |job| job.quality <= -3 }
  end
end
