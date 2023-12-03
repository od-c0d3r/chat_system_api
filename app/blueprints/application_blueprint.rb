class ApplicationBlueprint < Blueprinter::Base
  identifier :token

  fields :name, :chats_count, :created_at, :updated_at

  association :chats, blueprint: ChatBlueprint
end
