class ProfilesController < ApplicationController
  skip_before_action :authenticate!, only: :create
  after_action :resource_response, expect: :destroy
  after_action :resorce_destroy_response, only: :destroy

  def show
    @user = current_user
  end

  private

  def resource
    @user = User.new resource_params
  end

  def resource_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def resource_response
    render json: @resource, root: false
  end

  def resorce_destroy_response
    render status: 204
  end
end