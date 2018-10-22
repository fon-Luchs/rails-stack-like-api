class RateBuilder
  def initialize(current_user, params = {}, permitted_params = {})
    @params = params
    @permitted_params = permitted_params
    @current_user = current_user
    set_parent
  end

  def build!
    check_rate
    rate = @parent.rate.new @permitted_params
    rate
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

  def check_rate
    render_403('Forbidden') && return if Rate.exists?(rate_params)
    render_403('Forbidden') && return if @parent.user_id == @current_user.id
  end

  def render_errors(errors, status)
    render json: { errors: Array(errors) }, status: status
  end

  def render_403(errors)
    render_errors(errors, 403)
  end

  def render_204(errors)
    render_errors(errors, 204)
  end
end
