class Api::V1::ApplicationsController < ApplicationController
  before_action :set_application, only: %i[show update]

  def index
    applications = Application.all

    render_success_response ApplicationBlueprint.render(applications), 'Applications fetched successfully', 200
  end

  def show
    if @application
      render_success_response(ApplicationBlueprint.render(@application, view: :with_chats),
                              'Application fetched successfully', 200)
    else
      render_error_response 'Application not found', 404
    end
  end

  def create
    application = Application.new application_params

    if application.save
      render_success_response ApplicationBlueprint.render(application), 'Application created successfully', 201
    else
      render_error_response application.errors.full_messages, 400
    end
  end

  def update
    if @application.update(application_params)
      render_success_response ApplicationBlueprint.render(@application), 'Application updated successfully', 200
    else
      render_error_response 'Application not found', 404
    end
  end

  private

  def set_application = @application = Application.find_by_token(params[:token])

  def application_params = params.require(:application).permit(:name)
end
