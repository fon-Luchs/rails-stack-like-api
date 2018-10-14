class BaseController < ApplicationController
  def create
    render :errors unless resource.save
  end

  def destroy
    resource.destroy
    render json: '204 NO CONTENT', status: 204
  end

  def update
    render :errors unless resource.update(resource_params)
  end
end
