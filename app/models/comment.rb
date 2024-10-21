class Comment < ApplicationRecord
  belongs_to :story

  validates :text, presence: true
end
