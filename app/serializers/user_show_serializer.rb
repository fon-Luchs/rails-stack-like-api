class UserShowSerializer < UserBaseSerializer
  attributes :reputation, :name, :answered_questions, :self_questions

  has_many :questions, key: :self_questions

  def name
    { name: object.first_name + ' ' + object.last_name }
  end

  def answered_questions
    answers = object.answers
    arr = []
    answers.each{ |a| arr << a.question }
    serialize_arr = []
    arr.each { |a| serialize_arr << QuestionSerializer.new(a, root: false) }

    { self_question: serialize_arr }
  end
end
