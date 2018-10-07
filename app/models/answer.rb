class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  validates :body, length: { minimum: 5 }

  after_tuch :set_rating
  ater_touch :set_user_reputation

end
