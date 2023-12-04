module Chat::Validations
  extend ActiveSupport::Concern

  included do
    validates :number, uniqueness: { scope: :application_id }
  end
end
