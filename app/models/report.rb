class Report < ApplicationRecord
  belongs_to :user
  has_many_attached :pictures
  validates :title, presence: true
  has_many :comments, as: :commentable,
           dependent: :destroy
end
