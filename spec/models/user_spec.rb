require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { should have_one(:auth_token).dependent(:destroy) }

  it { should have_many(:questions) }

  it { should have_many(:answers) }

  it { should have_many(:rate) }

  it { should validate_presence_of(:first_name) }

  it { should validate_presence_of(:last_name) }
end
