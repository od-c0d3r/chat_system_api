class Message < ApplicationRecord
  include Searchable
  include Message::Callbacks

  belongs_to :chat

  validates :number, uniqueness: { scope: :chat_id }
end
