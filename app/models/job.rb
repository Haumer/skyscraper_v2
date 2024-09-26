class Job < ApplicationRecord
  belongs_to :website
  has_many :search_jobs, dependent: :destroy
  has_many :searches, through: :search_jobs

  validates :title,  presence: true
  validates :salary, presence: true
  validates :location, presence: true
  validates :link, presence: true, uniqueness: true
  validates :job_website, presence: true
  validates :quality, presence: true

  def width
    'grid-item--width2' if quality > 2
  end

  def height
    'grid-item--height2' if quality > 3
  end

  def title_length
    return 999 if quality > 3
    return 70 if quality > 2
    return 30 if quality > 3
  end
end
