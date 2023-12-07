class Chat < ApplicationRecord
  include Chat::Relations
  include Chat::Validations
  include Chat::Callbacks
end
