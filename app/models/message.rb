class Message < ApplicationRecord
  include Message::Relations
  include Message::Validations
  include Message::Callbacks
  include Message::Searchable
end
