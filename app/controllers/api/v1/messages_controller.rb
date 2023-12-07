class Api::V1::MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat
  before_action :set_message, only: %i[update show]

  def index
    messages = @chat.messages

    if @application && @chat
      render_success_response(messages, 'Messages fetched successfully', 200)
    else
      render_not_found(@application, @chat)
    end
  end

  def show
    if @application && @chat && @message
      render_success_response(@message, 'Message fetched successfully', 200)
    else
      render_not_found(@application, @chat, @message)
    end
  end

  def create
    message = @chat&.messages&.new message_params

    if @chat && @application && message.save
      message.chat.update(messages_count: message.chat.messages_count + 1) # worker needed

      render_success_response(message, 'Message created successfully', 201)
    else
      render_not_found(@application, @chat, message)
    end
  end

  def update
    if @chat && @application && @message
      @message.update message_params

      render_success_response(@message, 'Message updated successfully', 200)
    else
      render_not_found(@application, @chat, @message)
    end
  end

  private

  def message_params = params.require(:message).permit(:body)

  def set_application = @application = Application.find_by_token(params[:application_token])

  def set_chat = @chat = @application&.chats&.find_by_number(params[:chat_number])

  def set_message = @message = @chat&.messages&.find_by_number(params[:number])

  def render_not_found(application = nil, chat = nil, message = nil)
    return render_error_response('Application not found', 404) unless application
    return render_error_response('Chat not found', 404) unless chat

    render_error_response('Message not found', 404) unless message
  end
end
