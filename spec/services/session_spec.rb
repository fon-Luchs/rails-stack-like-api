require 'rails_helper'

RSpec.describe Session do
  let(:password) { FFaker::Internet.password }

  let(:email) { FFaker::Internet.email }

  subject { Session.new email: email, password: password }

  it { should delegate_method(:auth_token).to(:user) }

  it { should delegate_method(:auth_token_value).to(:auth_token).as(:value) }

  describe '#user' do
    before { expect(User).to receive(:find_by).with(email: email).and_return(:user) }

    its(:user) { should eq :user }
  end

  describe '#password?' do
    let(:user) { double }

    before { expect(subject).to receive(:user).and_return(user) }

    context do
      before { expect(user).to receive(:authenticate).with(password).and_return(true) }

      its(:password?) { should eq true }
    end

    context do
      before { expect(user).to receive(:authenticate).with(password).and_return(false) }

      its(:password?) { should eq false }
    end
  end

  describe '#valid?' do
    let(:session) { Session.new email: email, password: password }

    subject { session.errors }

    context do
      before { expect(session).to receive(:user) }

      before { session.valid? }

      its([:email]) { should eq ['not found'] }
    end

    context do
      before { expect(session).to receive(:user).and_return(:user) }

      before { expect(session).to receive(:password?).and_return(false) }

      before { session.valid? }

      its([:password]) { should eq ['is invalid'] }
    end
  end

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      its(:save) { should eq false }
    end

    context do
      let(:user) { double }

      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:user).and_return(user) }

      before { expect(user).to receive(:create_auth_token).and_return('x-y-z') }

      its(:save) { should eq true }
    end
  end

  describe '#as_json' do
    before { expect(subject).to receive(:auth_token_value).and_return('xxxx-yyyy-zzzz') }

    its(:as_json) { should eq auth_token: 'xxxx-yyyy-zzzz' }
  end
end