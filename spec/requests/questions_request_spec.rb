# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe 'Questions', :vcr, type: :request do
  it 'Creates questions with new sentences' do
    sentence = 'A new exquisite sentence'
    post '/questions', params: { question: { sentence: sentence } }

    expect(response).to have_http_status(:created)
    expect(Question.first.sentence.original).to eq(sentence)
  end

  it 'Creates questions with existing sentences' do
    sentence = 'A new exquisite sentence'
    Sentence.create(original: sentence)
    post '/questions', params: { question: { sentence: sentence } }

    expect(response).to have_http_status(:created)
    expect(Question.count).to eq(1)
    expect(Question.first.sentence.original).to eq(sentence)
  end

  it 'gets questions' do
    Question.from_nyt

    get '/questions.json'

    expect(response).to have_http_status(:ok)

    body = JSON.parse(response.body, symbolize_names: true)
    json_question = body.sample
    db_question = Question.find(json_question[:id])

    expect(body.length).to be Question.count
    expect(json_question[:question]).to eq db_question.formatted
    expect(json_question[:options]).to eq db_question.options.pluck(:name)
  end
end
