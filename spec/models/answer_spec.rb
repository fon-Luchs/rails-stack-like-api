require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }

  it { should belong_to(:user) }

  it { should have_many(:rate) }

  it { should validate_length_of(:body).is_at_least(5) }

  it { should callback(:set_rating).after(:touch) }

  it { should callback(:set_reputation).after(:touch) }
end
