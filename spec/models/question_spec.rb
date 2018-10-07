require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }

  it { should have_many(:rate) }

  it { should belong_to(:user) }

  it { should validate_length_of(:body).is_at_least(5) }

  it { should validate_length_of(:title).is_at_least(5) }

  it { should callback(:set_rating).after(:touch) }

  it { should callback(:set_reputation).after(:touch) }
end
