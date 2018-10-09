class Answer < ApplicationRecord
  include ReputationCounter

  belongs_to :question
  belongs_to :user
  has_many :rate, as: :rateable

  validates :body, presence: true
  validates :body, length: { minimum: 5 }

  after_touch :set_rating
  after_touch :set_reputation
end
