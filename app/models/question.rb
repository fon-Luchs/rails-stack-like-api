class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 5 }

  validates :body, presence: true
  validates :body, length: { minimum: 5 }

  after_tuch :set_rating
  ater_touch :set_user_reputation
end
