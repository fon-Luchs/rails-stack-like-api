class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :self_question, :self_answers

  def self_question
    data = super
    data[:self_question] = questions.all
    data
  end

  def self_answers
    data = super
    data[:self_answers] = answers.all
    data
  end
end
