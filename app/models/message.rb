class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates :text, presence: true, length: { maximum: 160 }
end
