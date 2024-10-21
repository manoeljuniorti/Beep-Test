class Story < ApplicationRecord
  self.primary_key = :id
  has_many :comments

  validates :title, presence: true
  validates :url, presence: true
end
