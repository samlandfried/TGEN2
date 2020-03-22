# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe 'Check Answer', :vcr, type: :request do
  before :each do
    sentence = Sentence.create(original: 'A mesmerizing sentence.')
    @question = Question.create(sentence: sentence)
  end

  it 'checks correct answers' do
    answer = @question.correct.name

    post "/questions/#{@question.id}/check_answer", { params: { check_answer: { word: answer } } }

    expect(response).to have_http_status(:ok)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:code]).to eq 'CORRECT'
    expect(body[:message]).to eq "Option '#{answer}' completes the sentence."
  end

  it 'checks incorrect answers' do
    answer = @question.options.find_by(correct: false).name

    post "/questions/#{@question.id}/check_answer", { params: { check_answer: { word: answer } } }

    expect(response).to have_http_status(:ok)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:code]).to eq 'INCORRECT'
    expect(body[:message]).to eq "Option '#{answer}' does not complete the sentence."
  end

  it '404s when an answer is not found on question options' do
    answer = 'Not found'

    post "/questions/#{@question.id}/check_answer", { params: { check_answer: { word: answer } } }

    expect(response).to have_http_status(:not_found)
  end
end
