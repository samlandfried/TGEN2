# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

NEW_SENTENCE = 'New phenomenal sentence'

RSpec.describe Question, :vcr, type: :model do
  it 'requires a sentence' do
    expect(Question.new).to_not be_valid
    sentence = Sentence.create(original: NEW_SENTENCE)
    expect(Question.new(sentence: sentence)).to be_valid
  end

  it 'chooses a random testable word if none is specified' do
    sentence = Sentence.create(original: NEW_SENTENCE)
    question = Question.create(sentence: sentence)
    expect(question.word_under_test).to eq(1)
  end
end
