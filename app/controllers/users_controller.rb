class UsersController < ApplicationController
  def index
    @users = Users.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
  end
end
