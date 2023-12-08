class ChatBlueprint < Blueprinter::Base
  identifier :number

  fields :messages_count, :created_at, :updated_at

  view :with_messages do
    association :messages, blueprint: MessageBlueprint
  end
end
