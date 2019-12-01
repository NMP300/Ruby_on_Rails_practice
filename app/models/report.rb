class Report < ApplicationRecord
  belongs_to :user
  has_many_attached :pictures
  validates :title, presence: true
end
