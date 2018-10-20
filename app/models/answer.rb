class Answer < ApplicationRecord
  include ReputationCounter

  belongs_to :user
  belongs_to :question
  has_many :rate, as: :rateable, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { minimum: 5 }
end
