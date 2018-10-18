require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user, :with_auth_token) }

  let(:answer)   { stub_model Answer }

  let(:question) { stub_model Question }

  let(:value)    { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:body) { FFaker::LoremUA.paragraph }

  let(:params) do
    {
      answer: { body: body, user_id: user.id }
    }
  end

  let(:permitted_params) { permit_params! params, :answer }

  before { sign_in user }

  describe '#create.json' do
    let(:params) do
      {
        answer: { body: body, user_id: user.id },
        question_id: question.id
      }
    end

    before { find_question }

    before do
      expect(question).to receive_message_chain(:answers, :build)
        .with(no_args).with(permitted_params)
        .and_return(answer)
    end

    context 'success' do
      before { expect(answer).to receive(:save).and_return(true) }

      before { merge_header }

      before {post :create, params: params, format: :json}

      it { should render_template :create }
    end

    context 'fails' do
      before { expect(answer).to receive(:save).and_return(false) }

      before { merge_header }

      before {post :create, params: params, format: :json}

      it { should render_template :errors }
    end
  end

  describe '#index.json' do
    before { find_question }

    before { merge_header }

    before { get :index, params: { question_id: question.id.to_s }, format: :json }

    it { should render_template :index }
  end

  describe 'routes test' do
    it { should route(:get, '/questions/1/answers').to(action: :index, controller: :answers, question_id: 1) }

    it { should route(:post, '/questions/1/answers').to(action: :create, controller: :answers, question_id: 1) }
  end

  def find_question
    expect(Question).to receive(:find)
      .with(question.id.to_s)
      .and_return(question)
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
