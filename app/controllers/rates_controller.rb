class RatesController < ApplicationController
  before_action :set_rateable, only: :create

  private

  def resource
    @rate = @rateable.rate.new resource_params
  end

  def resource_params
    params.require(:rate).permit(:kind)
  end

  def set_rateable
    @rateable = ModelLoader([Question, Answer], params).load_rateable
  end
end