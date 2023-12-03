class Api::V1::ApplicationsController < ApplicationController
  def index
    applications = Application.all

    render_success_response applications, 'Applications fetched successfully', 200
  end

  def show
    token = application_params[:token]
    application = Application.find_by_token token

    if application
      render_success_response(application, 'Application fetched successfully', 200)
    else
      render_error_response('Application not found', 404)
    end
  end

  def create
    application = Application.new application_params

    if application.save
      render_success_response(application, 'Application created successfully', 201)
    else
      render_error_response(application.errors.full_messages, 400)
    end
  end

  def update
    token = application_params[:token]
    application = Application.find_by_token token

    if application
      application.update application_params
      render_success_response(application, 'Application updated successfully', 200)
    else
      render_error_response('Application not found', 404)
    end
  end

  private

  def application_params
    params.permit(:name, :token)
  end

  def render_error_response(errors = [], code = 400)
    render json: {
      errors: errors,
      status_code: code
    }, status: code
  end

  def render_success_response(data = nil, message = nil, code = 200)
    render json: {
      data: data,
      message: message,
      status_code: code
    }, status: code
  end
end
