class Website < ApplicationRecord
  validates :link, presence: true
  validates :name, presence: true
end
