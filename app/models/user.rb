# User class
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, # :timeoutable,
         :omniauthable, authentication_keys: [:login] #:omniauth_providers => [:facebook]

  attr_accessor :login

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :messages, dependent: :destroy

  has_many :followers, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :follows, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers_list, through: :followers, source: :followed
  has_many :followings, through: :follows, source: :follower

  def self.from_omniauth(uid, auth)
    info = auth.info
    email = info.email
    where(email: email).first_or_create do |user|
      user.uid = uid
      user.username = info.username
      user.email = email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params,session)
    user_attributes = session['devise.user_attributes']
    if user_attributes
      new(user_attributes,without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def full_name
    full_name = first_name + ' ' + last_name
    full_name == ' ' ? username : full_name
  end

  def avatar
    'default.jpg'
  end

  def total_messages
    messages.count
  end

  def total_followings
    follows.count
  end

  def total_followers
    followers.count
  end

  def is_follower?(user)
    return false if user.id == id
    followings.where(id: user.id).take.try(:id)
  end

  private

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    query = where(conditions.to_hash)
    if login
      query.where(['lower(username) = :value OR lower(email) = :value', {value: login.downcase}]).take
    else
      query.take
    end
  end

end
