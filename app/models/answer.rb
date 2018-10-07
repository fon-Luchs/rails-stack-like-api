class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :rate, as: :rateable

  validates :body, presence: true
  validates :body, length: { minimum: 5 }
end
