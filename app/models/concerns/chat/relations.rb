module Chat::Relations
  extend ActiveSupport::Concern

  included do
    belongs_to :application
    has_many :messages
  end
end
