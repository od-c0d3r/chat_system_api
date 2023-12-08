class Api::V1::MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat
  before_action :set_message, only: %i[show update]

  def index
    messages = @chat.messages

    if @application && @chat
      render_success_response(MessageBlueprint.render(messages), 'Messages fetched successfully', 200)
    else
      render_error(@application, @chat)
    end
  end

  def show
    if @application && @chat && @message
      render_success_response(MessageBlueprint.render(@message), 'Message fetched successfully', 200)
    else
      render_error(@application, @chat, @message)
    end
  end

  def create
    message = @chat&.messages&.new message_params

    if @chat && @application && message.save
      Messages::UpdateChatMessagesCounterJob.perform_async @chat.id

      render_success_response(MessageBlueprint.render(message), 'Message created successfully', 201)
    else
      render_error(@application, @chat, message)
    end
  end

  def update
    if @chat && @application && @message&.update(message_params)
      render_success_response(MessageBlueprint.render(@message), 'Message updated successfully', 200)
    else
      render_error(@application, @chat, @message)
    end
  end

  private

  def message_params = params.require(:message).permit(:body)

  def set_application = @application = Application.find_by_token(params[:application_token])

  def set_chat = @chat = @application&.chats&.find_by_number(params[:chat_number])

  def set_message = @message = @chat&.messages&.find_by_number(params[:number])
end
