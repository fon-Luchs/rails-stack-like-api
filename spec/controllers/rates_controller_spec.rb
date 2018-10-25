require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  let(:user) { create(:user, :with_auth_token) }

  let(:answer) { create(:answer) }

  let(:rate) do
    create(
      :rate, id: 1, user: answer.user,
      rateable_id: answer.id,
      rateable_type: answer.class.name
    )
  end

  let(:params) { { rate: { kind: 'positive', user: user } } }

  let(:permitted_params) { permit_params! params, :rate }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#create.json' do
    let(:rate_builder) { RateBuilder.new user, controller_params, permitted_params }

    let(:request_params) do
      {
        rate: { kind: 'positive' },
        answer_id: answer.id
      }
    end

    let(:controller_params) do
      ActionController::Parameters.new({
        rate: ActionController::Parameters.new({kind: 'positive'}),
        answer_id: answer.id.to_s,
        format: 'json',
        controller: 'rates',
        action: 'create'
      })
    end

    before do
      expect(RateBuilder).to receive(:new)
        .with(user, controller_params, permitted_params)
        .and_return(rate_builder).twice
    end

    before { expect(rate_builder).to receive(:build!).and_return(rate) }

    context 'success' do
      before { expect(rate).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: request_params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(rate).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: request_params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'routes test' do
    it do
      should route(:post, 'answers/1/rate').to(
        controller: :rates,
        action: :create, answer_id: 1
        )
    end

    it do
      should route(:post, 'questions/1/rate').to(
        controller: :rates,
        action: :create, question_id: 1
      )
    end
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
