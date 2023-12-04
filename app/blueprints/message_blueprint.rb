class MessageBlueprint < Blueprinter::Base
  identifier :number

  fields :body, :created_at, :updated_at

  association :chat, blueprint: ChatBlueprint
end
