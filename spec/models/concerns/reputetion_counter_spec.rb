require 'rails_helper'

RSpec.describe ReputationCounter, type: :module do
  let(:user) { create(:user) }

  let(:question) { create(:question, rating: 0) }
  
  describe '#set_rating' do
    context 'positive rate' do
      before { rate_possitive?(true) }

      it {}
    end

    context 'negative rate' do
      before { rate_possitive?(false) }

      it {}
    end
  end

  describe '#set_reputation' do
    context 'positive rate' do
      before { rate_possitive?(true) }

      it {}
    end

    context 'negative rate' do
      before { rate_possitive?(false) }

      it {}
    end
  end

  def rate_possitive?(returned_ress)
    expect(self).to receive_message_chain(:rate, :kind, :possitive?)
      .with(no_args).with(no_args).with(no_args)
      .and_return(returned_ress)
  end

  def rate_negative?(returned_ress)
    expect(self).to receive_message_chain(:rate, :kind, :negative?)
      .with(no_args).with(no_args).with(no_args)
      .and_return(returned_ress)
  end
end
