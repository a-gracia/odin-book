class User < ApplicationRecord
  has_many :posts

  has_many :likes

  has_many :being_followed, class_name: "Follow", foreign_key: :followed_id
  has_many :followers, through: :being_followed, source: :follower

  has_many :being_follower, class_name: "Follow", foreign_key: :follower_id
  has_many :following, through: :being_follower, source: :followed


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
