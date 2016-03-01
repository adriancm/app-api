class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validates_presence_of :follower, :followed
  validate :check_not_follow_yourself

  def check_not_follow_yourself
    errors.add(:followed, "can't follow yourself") if follower == followed
  end
end
