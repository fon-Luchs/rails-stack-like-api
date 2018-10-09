class Question < ApplicationRecord
  include ReputationCounter

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :rate, as: :rateable

  validates :title, presence: true
  validates :title, length: { minimum: 5 }

  validates :body, presence: true
  validates :body, length: { minimum: 5 }

  after_touch :set_rating
  after_touch :set_reputation
end
