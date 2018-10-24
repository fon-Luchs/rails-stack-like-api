class UsersController < BaseController

  private

  def resource
    @user = User.find(params[:id])
  end

  def collection
    @users = User.all.order('reputation DESC')
  end
end
