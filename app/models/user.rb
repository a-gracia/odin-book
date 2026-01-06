class User < ApplicationRecord
  has_many :posts

  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  has_many :comments

  has_many :being_followed, class_name: "Follow", foreign_key: :followed_id
  has_many :followers, through: :being_followed, source: :follower

  has_many :being_follower, class_name: "Follow", foreign_key: :follower_id
  has_many :following, through: :being_follower, source: :followed

  has_many :accepted_follows, -> { accepted }, class_name: "Follow", foreign_key: :follower_id
  has_many :following_accepted, through: :accepted_follows, source: :followed

  has_many :requested_follows, -> { requested }, class_name: "Follow", foreign_key: :follower_id
  has_many :following_requested, through: :requested_follows, source: :followed

  after_create -> { UserMailer.with(user: self).welcome_email.deliver_later }

  has_one_attached :profile_picture

  def get_profile_picture
    if profile_picture.attached?
      profile_picture
    else
      "https://api.dicebear.com/9.x/big-smile/svg?seed=#{id}"
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
    # Try to find user by provider and uid first
    user = where(provider: auth.provider, uid: auth.uid).first

    # If not found, try to find by email
    user ||= find_by(email: auth.info.email)

    # If user found by email but no provider/uid, update them
    if user
      user.update(provider: auth.provider, uid: auth.uid) if user.provider.nil? || user.uid.nil?
      return user
    end

    # Otherwise, create new user
    create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end
end
