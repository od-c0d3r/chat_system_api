module Message::Validations
  extend ActiveSupport::Concern

  included do
    validates :number, uniqueness: { scope: :chat_id }
    validates :body, presence: true
  end
end
