class Search < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :websites, -> { distinct }, through: :jobs
  belongs_to :user
  validates :keyword, presence: true
  validates :location, presence: true

  def top_jobs
    jobs.where('quality >= ?', 3)
  end

  def low_jobs
    jobs.where('quality >= ?', -2)
  end

  # private

  def report
    ap [
      {
        "total" => jobs.count,
        "avg" => (jobs.map { |e| e.quality }.sum).to_f / jobs.count
      },
      {
        "top total (+3)" => top_jobs.count,
        "avg" => (top_jobs.map { |e| e.quality }.sum).to_f / top_jobs.count
      },
      {
        "low total (-2)" => low_jobs.count,
        "avg" => (low_jobs.map { |e| e.quality }.sum).to_f / low_jobs.count
      }
    ]
  end

  def avg_salary
    selected = jobs.where.not(upper_salary: nil)
    total = selected.map do |job|
      (job.upper_salary + job.lower_salary) / 2 unless job.upper_salary > 200000 || job.lower_salary > 200000
    end.reject(&:blank?)
    { avg: total.sum / total.count, count: total.count }
  end

  def highest_salary
    jobs.where.not(upper_salary: nil).order(lower_salary: :desc).first
  end
end
