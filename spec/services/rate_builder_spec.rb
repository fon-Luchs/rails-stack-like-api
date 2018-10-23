require 'rails_helper'

RSpec.describe RateBuilder do
  let(:user) { create(:user, :with_auth_token) }

  let(:answer) { create(:answer) }

  let(:rate)   { stub_model Rate }

  let(:controller_params) do
    ActionController::Parameters.new({
      rate: ActionController::Parameters.new({kind: 'positive'}),
      answer_id: answer.id.to_s,
      format: 'json',
      controller: 'rates',
      action: 'create'
    })
  end

  let(:params) { { rate: { kind: 'positive', user: user } } }

  let(:permitted_params) { permit_params! params, :rate }

  let(:rate_builder) { RateBuilder.new user, controller_params, permitted_params }

  describe '#initialize' do
    it do
      expect(rate_builder.instance_variable_get(:@params))
        .to eq(controller_params)
    end

    it do
      expect(rate_builder.instance_variable_get(:@permitted_params))
        .to eq(permitted_params)
    end

    it do
      expect(rate_builder.instance_variable_get(:@current_user))
        .to eq(user)
    end
  end

  describe '#build' do
    before { set_patent }

    before { expect(Rate).to receive(:exists?).with(rate_params).and_return(false) }

    before do
      expect(answer).to receive_message_chain(:user_id, :==)
        .with(no_args).with(user.id)
        .and_return(false)
    end

    before do
      expect(answer).to receive_message_chain(:rate, :new)
        .with(permitted_params)
        .and_return(rate)
    end

    it { expect(rate).to eq(rate_builder.build!) }
  end

  def set_patent
    expect(Answer).to receive(:find).with(answer.id.to_s).and_return(answer)
  end

  def rate_params
    {
      rateable_id: answer.id,
      user_id: user.id,
      rateable_type: answer.class.name
    }
  end
end
