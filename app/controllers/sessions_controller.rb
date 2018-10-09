class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def destroy
    @session = current_user
    @session.auth_token.destroy
    render status: 204, json: 'No Content'
  end

  private

  def resource
    @session ||= Session.new resource_params
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end

  def resource_response
    render json: resource, serializer: SessionSerializer
  end
end