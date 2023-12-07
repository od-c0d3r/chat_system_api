class ApplicationController < ActionController::API
  def render_success_response(data = nil, message = nil, code = 200)
    render json: {
      data: data.as_json(except: %i[id chat_id application_id created_at updated_at]),
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
end
