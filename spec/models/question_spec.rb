# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

NEW_SENTENCE = 'New phenomenal sentence'

RSpec.describe Question, :vcr, type: :model do
  before(:each) do
    sentence = Sentence.create(original: NEW_SENTENCE)
    @question = Question.create(sentence: sentence)
  end

  it 'requires a sentence' do
    expect(Question.new).to_not be_valid
    sentence = Sentence.create(original: NEW_SENTENCE)
    expect(Question.new(sentence: sentence)).to be_valid
  end

  it 'can pull a sentence from NYT' do
    question = Question.from_nyt
    expect(question).to be_a Question
    expect(question.sentence).to be_a Sentence
  end

  it 'creates a formatted version of the sentence' do
    expect(@question.formatted).to eq 'New ___ sentence'
  end

  it 'chooses a random testable word if none is specified' do
    expect(@question.word_under_test_index).to eq(1)
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
    expect(@question.options.first.name).to eq('phenomenal')
    expect(@question.options.first.correct).to be true
  end

  it 'knows the correct option' do
    expect(@question.correct).to eq Option.find_by(correct: true)
  end

  it 'generates incorrect options' do
    incorrect = @question.create_incorrect_option
    expect(incorrect[:correct]).to be false
    expect(incorrect[:name].length).to be > 3
    expect(incorrect[:name].length).to be >= @question.word_under_test.length - 3
    expect(incorrect[:name].length).to be <= @question.word_under_test.length + 3
    expect(incorrect[:name]).to_not eq @question.correct.name
    expect(@question.options).to include incorrect
  end

  it 'creates 3 incorrect options' do
    expect(@question.options.count).to eq 4
    expect(@question.options.where(correct: false).count).to eq 3
    expect(@question.options.where(correct: true).count).to eq 1
  end

  it 'knows how to prepare itself for test taker' do
    expect(@question.for_test_taker).to eq(
      {
        question: 'New ___ sentence',
        options: %w[phenomenal labored charitable reprobate],
        id: 1
      }
    )
  end
end
