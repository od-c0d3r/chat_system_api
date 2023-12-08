class ApplicationBlueprint < Blueprinter::Base
  identifier :token

  fields :name, :chats_count, :created_at, :updated_at

  view :with_chats do
    association :chats, blueprint: ChatBlueprint
  end
end
