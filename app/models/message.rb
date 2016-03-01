class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates :text, presence: true, length: { maximum: 160 }

  scope :recent, -> (ids) { where(user_id: ids).order('created_at DESC') }

end
