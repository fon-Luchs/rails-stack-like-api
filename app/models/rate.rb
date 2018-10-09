class Rate < ApplicationRecord
  belongs_to :rateable, polymorphic: true
  belongs_to :user

  enum kind: [ :possitive, :negative ]
end
