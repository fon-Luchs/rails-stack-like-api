require 'rails_helper'

RSpec.describe RateCounter do
  let(:answer) { stub_model Answer, rating: 0 }

  let(:user) { stub_model User, reputation: 0 }

  let(:rate) do
    stub_model Rate, user: user, rateable_id: answer.id,
    rateable_type: answer.class.name, kind: 'positive'
  end

  let(:rate_counter) { RateCounter.new rate }

  describe '#initialize' do
    it do
      expect(rate_counter.instance_variable_get(:@user))
        .to eq(rate.user)
    end

    it do
      expect(rate_counter.instance_variable_get(:@rate))
        .to eq(rate)
    end

    it do
      expect(rate_counter.instance_variable_get(:@klass))
        .to eq(rate.rateable_type.constantize)
    end
  end

  describe '#set_reputation' do
    before { expect(rate).to receive(:positive?).and_return(true) }

    it { should change(user, :reputation).by(1) }
  end
end
