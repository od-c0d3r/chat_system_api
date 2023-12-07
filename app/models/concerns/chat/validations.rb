module Chat::Validations
  extend ActiveSupport::Concern

  included do
    validates :number, uniqueness: { scope: :application_id }
    validates :messages_count, numericality: { greater_than_or_equal_to: 0 }
  end
end
