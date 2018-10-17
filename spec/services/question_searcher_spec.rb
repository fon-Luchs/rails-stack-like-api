require 'rails_helper'

RSpec.describe QuestionSearcher do
  let(:params) { { title: 'title', body: 'body' } }

  let(:question_searcher) { QuestionSearcher.new params }

  let(:question) { stub_model Question }

  let(:collection) { Question.all }

  describe '#initialize' do
    it do
      expect(question_searcher.instance_variable_get(:@title))
        .to eq(params[:title])
    end

    it do
      expect(question_searcher.instance_variable_get(:@body))
        .to eq(params[:body])
    end
  end

  describe '#search' do
    before { expect(Question).to receive(:all).and_return(collection) }

    before do
      expect(collection).to receive(:where)
        .with(params)
        .and_return(question)
    end

    it { expect(question).to eq(Question.where(title: question_searcher.title, body: question_searcher.body)) }
  end
end