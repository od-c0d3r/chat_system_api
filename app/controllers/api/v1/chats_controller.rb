class Api::V1::ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: %i[show update search]

  def index
    if @application
      chats = @application.chats
      render_success_response(chats, 'Chats fetched successfully', 200)
    else
      render_error_response('Application not found', 404)
    end
  end

  def show
    if @application && @chat
      render_success_response @chat, 'Chat fetched successfully', 200
    else
      return render_error_response('Application not found', 404) unless @application

      render_error_response('Chat not found', 404)
    end
  end

  def create
    chat = Chat.new application: @application

    if @application && chat.save
      Chats::CreateJob.perform_async @application.token

      render_success_response(chat, 'Chat created successfully', 201)
    else
      return render_error_response('Application not found', 404) unless @application

      render_error_response(chat.errors.full_messages, 404)
    end
  end

  def update
    if @application && @chat && @chat.update(chat_params)
      render_success_response(@chat, 'Chat updated successfully', 200)
    else
      return render_error_response('Application not found', 404) unless @application
      return render_error_response('Chat not found', 404) unless @chat

      render_error_response(@chat.errors.full_messages, 404)
    end
  end

  def search
    if @application && @chat
      messages = @chat.messages.search(search_param[:query])

      render_success_response(messages, 'Messages fetched successfully', 200)
    else
      return render_error_response('Application not found', 404) unless @application

      render_error_response('Chat not found', 404) unless @chat
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:messages_count)
  end

  def search_param
    params.permit(:query)
  end

  def set_application = @application = Application.find_by_token(params[:application_token])

  def set_chat = @chat = @application&.chats&.find_by_number(params[:chat_number] || params[:number])
end
