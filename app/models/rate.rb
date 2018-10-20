class Rate < ApplicationRecord
  belongs_to :rateable, polymorphic: true
  belongs_to :user

  validates :kind, presence: true

  enum kind: [:positive, :negative]
end
