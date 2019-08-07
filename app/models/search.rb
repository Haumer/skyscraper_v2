class Search < ApplicationRecord
  has_many :jobs, dependent: :destroy
  belongs_to :user
  validates :keyword, presence: true
  validates :location, presence: true
end
