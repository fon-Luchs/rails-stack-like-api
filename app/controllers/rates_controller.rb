class RatesController < BaseController
  before_action :set_perent
  before_action :check_rate

  def create
    if resource.save
      run_rate
    else
      render :errors
    end
  end

  private

  def resource
    @rate ||= @parent.rate.new resource_params
  end

  def resource_params
    params.require(:rate).permit(:kind).merge(user: current_user)
  end

  def set_perent
    @parent = Question.find(params[:question_id]) if params[:question_id]
    @parent = Answer.find(params[:answer_id]) if params[:answer_id]
  end

  def check_rate
    render_403('Forbidden') && return if Rate.exists?(rate_params)
    render_403('Forbidden') && return if @parent.user_id == current_user.id
  end

  def run_rate
    RateCounter.new(resource).set_counter!
  end

  def rate_params
    {
      rateable_id: @parent.id,
      user_id: current_user.id,
      rateable_type: @parent.class.name
    }
  end
end
