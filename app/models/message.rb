class Message < ApplicationRecord
  include Message::Callbacks

  belongs_to :chat

  validates :number, uniqueness: { scope: :chat_id }
end
