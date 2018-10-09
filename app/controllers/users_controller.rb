class UsersController < ApplicationController
  def index
    @users = Users.all.order('reputation DESC')
  end

  def show
    @user = User.find(params[:id])
  end
end
