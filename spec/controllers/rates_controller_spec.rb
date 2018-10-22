require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  # let(:rate) { stub_model Rate }

  # let(:user) { create(:user, :with_auth_token) }

  # let(:question) { stub_model Question }

  # let(:value) { user.auth_token.value }

  # let(:params) { { rate: { kind: 'positive' } } }

  # let(:permitted_params) { permit_params! params, :rate }

  # before { sign_in user }

  # let(:headers) do
  #   {
  #     'Authorization' => "Token token=#{value}",
  #     'Content-type' => 'application/json',
  #     'Accept' => 'application/json'
  #   }
  # end

  # describe '#create.json' do
  #   let(:rate_params) do
  #     {
  #       rateable_id: question.id,
  #       user_id: user.id,
  #       rateable_type: question.class.name
  #     }
  #   end

  #   let(:request_params) do
  #     { rate:
  #       {
  #         kind: 'positive'
  #       },

  #       question_id: question.id
  #     }
  #   end

  #   before { get_resource }

  #   context 'rate exist?' do
  #     before { expect(Rate).to receive(:exists?).with(rate_params).and_return(true) }

  #     before { merge_header }

  #     before { post :create, params: request_params, format: :json }

  #     it { expect(response).to have_http_status(:forbidden) }
  #   end

  #   context 'resource current_user?' do
  #     before do
  #       expect(question).to receive_message_chain(:user_id, :==)
  #         .with(no_args).with(user.id)
  #         .and_return(true)
  #     end

  #     before { merge_header }

  #     before { post :create, params: request_params, format: :json }

  #     it { expect(response).to have_http_status(:forbidden) }
  #   end

  #   context 'success' do
  #     before { expect(rate).to receive(:save).and_return(true) }

  #     before { merge_header }

  #     before { post :create, params: request_params, format: :json }

  #     it { should render_template :create }
  #   end

  #   context 'fail' do
  #     before { expect(rate).to receive(:save).and_return(false) }

  #     before { merge_header }

  #     before { post :create, params: request_params, format: :json }

  #     it { should render_template :errors }
  #   end
  # end

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

  # def merge_header
  #   request.headers.merge!(headers)
  # end

  # def get_resource
  #   expect(Question).to receive(:find).with(question.id.to_s).and_return(question)
  # end
end
