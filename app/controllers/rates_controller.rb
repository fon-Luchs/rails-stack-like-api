class RatesController < BaseController
  before_action :set_perent
  after_action :run_rate

  def create
    render status: 403 if Rate.exists?(rate_params)
    render status: 403 if @parent.user_id == current_user.id
    super
  end

  private

  def resource
    @rate ||= @parent.rate.new resource_params
  end

  def resource_params
    params.require(:rate).permit(:kind)
  end

  def set_perent
    @parent = Question.find(params[:question_id]) if params[:question_id]
    @parent = Answer.find(params[:answer_id]) if params[:answer_id]
  end

  def run_rate
    rate_counter = RateCounter.new(resource).set_counter
  end

  def rate_params
    {
      rateable_id: @parent.id,
      user_id: current_user.id,
      rateable_type: @parent.class.name
    }
  end
end
