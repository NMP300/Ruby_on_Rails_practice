# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[6, 20]
    end
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  validates :name, presence: true
  validates :email, presence: true
  validates :password, confirmation: true

  has_many :books,
           foreign_key: "user_id",
           dependent: :destroy
  has_many :reports,
           foreign_key: "user_id",
           dependent: :destroy
  has_one_attached :icon
  has_many :active_follows, class_name: "Follow",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :passive_follows, class_name: "Follow",
           foreign_key: "followed_id",
           dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  has_many :comments, foreign_key: "user_id", dependent: :destroy
end
