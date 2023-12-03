class Api::V1::ApplicationsController < ApplicationController
  # GET /api/v1/applications
  def index
    applications = Application.all

    render_success_response(ApplicationBlueprint.render(applications), 'Applications fetched successfully', 200)
  end

  # GET /api/v1/applications/:token
  def show
    token = application_params[:token]
    application = Application.find_by_token token

    if application
      render_success_response(ApplicationBlueprint.render(application), 'Application fetched successfully', 200)
    else
      render_error_response('Application not found', 404)
    end
  end

  # POST /api/v1/applications
  def create
    application = Application.new application_params

    if application.save
      render_success_response(ApplicationBlueprint.render(application), 'Application created successfully', 201)
    else
      render_error_response(application.errors.full_messages, 400)
    end
  end

  # PATCH /api/v1/applications/:token
  def update
    token = application_params[:token]
    application = Application.find_by_token token

    if application
      begin
        application.update application_params
        render_success_response(ApplicationBlueprint.render(application), 'Application updated successfully', 200)
      rescue StandardError => e
        render_error_response(e.message, 404)
      end
    else
      render_error_response('Application not found', 404)
    end
  end

  private

  def application_params
    params.permit(:name, :token)
  end
end
