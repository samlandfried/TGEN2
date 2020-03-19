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
    expect(question.word_under_test_index).to eq(1)
  end

  it 'allows testable word to be specified' do
    sentence = Sentence.create(original: 'quazar incandescent quagmire')
    question = Question.create(sentence: sentence, word_under_test_index: 2)
    expect(question.word_under_test_index).to eq(2)
  end

  it 'does not allow an untestable word to be specified' do
    sentence = Sentence.create(original: 'common quazar incandescent quagmire')
    expect { Question.create(sentence: sentence, word_under_test_index: 0) }.to raise_exception('Word under test is not a testable word')
  end

  it 'creates a correct option with the word under test' do
    sentence = Sentence.create(original: NEW_SENTENCE)
    question = Question.create(sentence: sentence)
    expect(question.options.first.name).to eq('phenomenal')
    expect(question.options.first.correct).to be true
  end

  it 'knows the correct option' do
    sentence = Sentence.create(original: NEW_SENTENCE)
    question = Question.create(sentence: sentence)
    expect(question.correct).to eq Option.find_by(correct: true)
  end
end
