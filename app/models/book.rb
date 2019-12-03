# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader

  validates :title, presence: true

  belongs_to :user
  has_many :comments, as: :commentable,
           dependent: :destroy
end
