require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }

  it { should belong_to(:user) }

  it { should validate_length_of(:body).is_at_least(5) }
end