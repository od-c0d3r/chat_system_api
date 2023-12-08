class Application < ApplicationRecord
  has_secure_token
  has_many :chats

  validates :name, presence: true
  validates :chats_count, numericality: { greater_than_or_equal_to: 0 }
end
