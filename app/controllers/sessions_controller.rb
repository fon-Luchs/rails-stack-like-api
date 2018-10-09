class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def create
    super
    render json: resource, serializer: SessionSerializer if resource.save
  end

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
end