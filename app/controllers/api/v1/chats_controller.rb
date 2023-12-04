class Api::V1::ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: %i[show update]

  def index
    if @application
      chats = @application.chats
      render_success_response(ChatBlueprint.render(chats), 'Chats fetched successfully', 200)
    else
      render_error_response('Application not found', 404)
    end
  end

  def show
    if @application && @chat
      render_success_response ChatBlueprint.render(@chat), 'Chat fetched successfully', 200
    else
      return render_error_response('Application not found', 404) unless @application

      render_error_response('Chat not found', 404)
    end
  end

  def create
    chat = Chat.new application: @application

    if chat.save
      render_success_response(ChatBlueprint.render(chat), 'Chat created successfully', 201)
    else
      render_error_response(chat.errors.full_messages, 404)
    end
  end

  def update
    if @application && @chat
      @chat.update chat_params.except(:application_token)

      render_success_response(ChatBlueprint.render(@chat), 200)
    else
      return render_error_response('Application not found', 404) unless @application

      render_error_response('Chat not found', 404) unless @chat
    end
  end

  private

  def chat_params = params.permit(:number, :messages_count, :application_token)

  def set_application = @application = Application.find_by(token: params[:application_token])

  def set_chat = @chat = @application&.chats&.find_by(number: params[:number])
end
