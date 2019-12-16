class Search < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :websites, -> { distinct }, through: :jobs
  belongs_to :user
  validates :keyword, presence: true
  validates :location, presence: true

  def top_jobs
    jobs.select { |job| job.quality >= 3 }
  end

  def low_jobs
    jobs.select { |job| job.quality <= -2 }
  end

  # private

  def report
    ap [
      {
        "total" => jobs.count,
        "avg" => (jobs.map {|e| e.quality}.sum).to_f / jobs.count
      },
      {
        "top total (+3)" => top_jobs.count,
        "avg" => (top_jobs.map {|e| e.quality}.sum).to_f / top_jobs.count
      },
      {
        "low total (-2)" => low_jobs.count,
        "avg" => (low_jobs.map {|e| e.quality}.sum).to_f / low_jobs.count
      }
    ]
  end
end
