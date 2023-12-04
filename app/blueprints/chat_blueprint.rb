class ChatBlueprint < Blueprinter::Base
  identifier :number

  fields :messages_count, :created_at, :updated_at

  association :messages, blueprint: MessageBlueprint
end
