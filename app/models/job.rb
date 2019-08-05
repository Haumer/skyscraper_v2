class Job < ApplicationRecord
  belongs_to :search

  validates :title,  presence: true
end
