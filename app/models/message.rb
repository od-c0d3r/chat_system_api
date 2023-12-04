class Message < ApplicationRecord
  belongs_to :chat
  validates :body, uniqueness: { scope: :chat_id }
end
