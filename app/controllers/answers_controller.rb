class AnswersController < BaseController
  before_action :set_question

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def resource
    @answer ||= @question.answers.build(resource_params)
  end

  def resource_params
    params.require(:answer).permit(:body).merge(user_id: current_user.id)
  end

  def collection
    @answers = @question.answers
  end
end
