class Api::V1::ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: %i[show update search]

  def index
    if @application
      chats = @application.chats

      render_success_response ChatBlueprint.render(chats), 'Chats fetched successfully', 200
    else
      render_error_response 'Application not found', 404
    end
  end

  def show
    if @application && @chat
      render_success_response ChatBlueprint.render(@chat, view: :with_messages), 'Chat fetched successfully', 200
    else
      render_error(@application, @chat)
    end
  end

  def create
    chat = Chat.new application: @application

    if @application && chat.save
      Chats::UpdateAppChatsCounterJob.perform_async @application.token

      render_success_response ChatBlueprint.render(chat), 'Chat created successfully', 201
    else
      render_error(@application, chat)
    end
  end

  def update
    if @application && @chat && @chat.update(chat_params)
      render_success_response ChatBlueprint.render(@chat), 'Chat updated successfully', 200
    else
      render_error(@application, @chat)
    end
  end

  def search
    if @application && @chat
      messages = @chat.messages.search search_param[:query]

      render_success_response MessageBlueprint.render(messages), 'Messages fetched successfully', 200
    else
      render_error(@application, @chat)
    end
  end

  private

  def chat_params = params.require(:chat).permit(:messages_count)

  def search_param = params.permit(:query)

  def set_application = @application = Application.find_by_token(params[:application_token])

  def set_chat = @chat = @application&.chats&.includes(:messages)&.find_by_number(params[:number] || params[:chat_number])
end
