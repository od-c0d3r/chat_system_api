class Api::V1::MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat
  before_action :set_message, only: %i[update show]

  def index
    messages = @chat.messages

    if @application && @chat
      render_message(messages, 'Messages fetched successfully', 200)
    else
      render_not_found(@application, @chat)
    end
  end

  def show
    if @application && @chat && @message
      render_message(@message, 'Message fetched successfully', 200)
    else
      render_not_found(@application, @chat, @message)
    end
  end

  def create
    message = @chat&.messages&.new message_params.except(:application_token, :chat_number)

    if @chat && @application && message.save
      message.chat.update(messages_count: message.chat.messages_count + 1) # worker needed

      render_message(message, 'Message created successfully', 201)
    else
      render_not_found(@application, @chat, message)
    end
  end

  def update
    if @chat && @application && @message
      @message.update message_params.except(:application_token, :chat_number)

      render_message(@message, 'Message updated successfully', 200)
    else
      render_not_found(@application, @chat, @message)
    end
  end

  private

  def message_params = params.permit(:body, :number, :chat_number, :application_token)

  def set_application = @application = Application.find_by_token(message_params[:application_token])

  def set_chat = @chat = @application.chats.find_by_number(message_params[:chat_number])

  def set_message = @message = @chat&.messages&.find_by_number(message_params[:number])

  def render_message(record, response_message = nil, code = 200)
    render_success_response(MessageBlueprint.render(record), response_message, code)
  end

  def render_not_found(application = nil, chat = nil, message = nil)
    return render_error_response('Application not found', 404) unless application
    return render_error_response('Chat not found', 404) unless chat

    render_error_response('Message not found', 404) unless message
  end
end
