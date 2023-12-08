module Message::Relations
  extend ActiveSupport::Concern

  included do
    belongs_to :chat
  end
end
