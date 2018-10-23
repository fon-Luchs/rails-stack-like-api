require 'rails_helper'

RSpec.describe Rate, type: :model do
  it { should belong_to(:rateable) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:kind) }

  it { should define_enum_for(:kind) }

  it { is_expected.to callback(:run_rate).after(:create) }
end
