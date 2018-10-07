class Rate < ApplicationRecord
  belongs_to :rateable, polymorphic: true

  enum kind: [ :possitive, :negative ]
end
