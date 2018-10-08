class UserShowSerializer < BaseUserSerializer
  attributes :answered_questions, :self_questions

  has_many :questions, key: :self_questions, serializer: BaseQuestionSerializer

  def answered_questions
    answers = object.answers
    arr = []
    answers.each{ |a| arr << a.question }
    serialize_arr = []
    arr.each { |a| serialize_arr << BaseQuestionSerializer.new(a, root: false) }
    { self_question: serialize_arr }
  end
end
