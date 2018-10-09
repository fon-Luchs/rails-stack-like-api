class RatesController < ApplicationController
  before_action :set_rateable, only: :create
  after_action :run_rate, only: :create

  def create
    render status: 403 unless Rate.where(rate_params).nil?
    render status: 403 if tateable.user_id == current_user.id
    super
  end

  private

  def resource
    @rate ||= @rateable.rate.new resource_params
  end

  def resource_params
    params.require(:rate).permit(:kind)
  end

  def resource_response
    serializer_class = if @rateable.class == Question
                         QuestionRelativeSerializer
                       else
                         BaseAnswerSerializer
                       end

    render json: resource, serializer: serializer_class
  end

  def set_rateable
    @rateable = ModelLoader([Question, Answer], params).load_rateable
  end

  def run_rate
    @rate.touch
  end

  def rate_params
    { rateable_id: rateable.id, user_id: current_user.id }
  end
end
