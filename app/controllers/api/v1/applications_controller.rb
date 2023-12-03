class Api::V1::ApplicationsController < ApplicationController
  def index
    @applications = Application.all

    render_success_response(@applications, 'Applications fetched successfully', 200)
  end

  private

  def render_success_response(data = nil, message = nil, code = 200)
    render json: {
      data: data,
      message: message,
      status_code: code
    }
  end
end
