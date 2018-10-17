require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user, :with_auth_token) }

  let(:question) { stub_model Question }

  let(:value) { user.auth_token.value }

  let(:title) { FFaker::LoremUA.sentence }

  let(:body)  { FFaker::LoremUA.paragraph }

  let(:params) do
    {
      question: {
        title: title,
        body: body
      }
    }
  end

  let(:permitted_params) { permit_params! params, :question }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#create.json' do
    before { build_resource }

    context 'success' do
      before { expect(question).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(question).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#update.json' do
    let(:params) do
      {
        question: {
          title: 'test',
          body: body
        },

        id: question.id
      }
    end

    before { expect(Question).to receive(:find).with(question.id.to_s).and_return(question) }

    context 'success' do
      before { expect(question).to receive(:update).and_return(true) }

      before { merge_header }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'fail' do
      before { expect(question).to receive(:update).and_return(false) }

      before { merge_header }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    before { merge_header }

    before { get :show, params: { id: question.id }, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    let(:params) { { title: 'test', body: body } }

    before { merge_header }

    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe 'routes test' do
  end

  def build_resource
    expect(user).to receive_message_chain(:questions, :new)
      .with(no_args).with(permitted_params).and_return(question)
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
