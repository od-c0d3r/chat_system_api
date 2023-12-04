class Chat < ApplicationRecord
  include Relations
  include Validations
  include Callbacks
end
