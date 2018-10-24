class RateBuilder
  def initialize(current_user, params = {}, permitted_params = {})
    @params = params
    @permitted_params = permitted_params
    @current_user = current_user
    set_parent
  end

  def build!
    rate = @parent.rate.new @permitted_params
    rate
  end

  def check_rate
    Rate.exists?(rate_params) && @parent.user_id == @current_user.id
  end

  private

  def set_parent
    @parent = Question.find(@params[:question_id]) if @params[:question_id]
    @parent = Answer.find(@params[:answer_id]) if @params[:answer_id]
  end

  def rate_params
    {
      rateable_id: @parent.id,
      user_id: @current_user.id,
      rateable_type: @parent.class.name
    }
  end
end
