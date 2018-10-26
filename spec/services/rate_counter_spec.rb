require 'rails_helper'

RSpec.describe RateCounter do
  let(:answer) { create(:answer) }

  let(:rate) do
    create(
      :rate, id: 1, user: answer.user,
      rateable_id: answer.id,
      rateable_type: answer.class.name
    )
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
      expect(rate_counter.instance_variable_get(:@parent))
        .to eq(answer)
    end

    it do
      expect(rate_counter.instance_variable_get(:@klass))
        .to eq(rate.rateable_type.constantize)
    end
  end

  describe '#set_reputation' do
    context '.increment' do
      before { expect(rate_counter).to receive(:rating_calculation!) }

      before { expect(rate).to receive(:positive?).and_return(true) }

      before do
        expect(answer).to receive(:increment).with(:rating)
      end

      it { expect { answer }.to change { answer.rating }.by(1) }
    end

    context '.decrement' do
      before { expect(rate_counter).to receive(:rating_calculation!) }

      before { expect(rate).to receive(:positive?).and_return(false) }

      before do
        expect(answer).to receive(:decrement).with(:rating)
      end

      it { expect { answer }.to change { answer.rating }.by(1) }
    end
  end

  describe '#set_rating' do
    context '.increment' do
      before { expect(rate_counter).to receive(:rating_calculation!) }

      before { expect(rate).to receive(:positive?).and_return(true) }

      before do
        expect(rate.user).to receive(:increment).with(:reputation)
      end

      it { expect { rate.user }.to change { rate.user.reputation }.by(1) }
    end

    context '.decrement' do
      before { expect(rate_counter).to receive(:rating_calculation!) }

      before { expect(rate).to receive(:positive?).and_return(false) }

      before do
        expect(rate.user).to receive(:decrement).with(:reputation)
      end

      it { expect { rate.user }.to change { rate.user.reputation }.by(1) }
    end
  end
end
