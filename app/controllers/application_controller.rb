class ApplicationController < ActionController::API
  def render_success_response(data = nil, message = nil, code = 200)
    render json: {
      data: JSON.parse(data),
      message: message,
      status_code: code
    }, status: code
  end

  def render_error_response(errors = [], code = 400)
    render json: {
      errors: errors,
      status_code: code
    }, status: code
  end

  def render_error(application = nil, chat = nil, message = nil)
    return render_error_response('Application not found', 404) unless application
    return render_error_response('Chat not found', 404) unless chat
    return render_error_response('Message not found', 404) unless message
    return render_error_response(chat.errors.full_messages, 409) if chat.errors.any?

    render_error_response(message.errors.full_messages, 409) if message.errors.any?
  end
end
