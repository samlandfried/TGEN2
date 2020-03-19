# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe Option, :vcr, type: :model do
  before(:each) do
    sentence = Sentence.create(original: 'New excruciatingly testable sentence')
    @question = Question.create(sentence: sentence)
  end

  it 'is unique by name' do
    option_a = 'Option A'
    Option.create(question: @question, name: option_a, correct: false)
    expect(Option.new(question: @question, name: option_a, correct: true)).to_not be_valid
    expect(Option.new(question: @question, name: option_a, correct: false)).to_not be_valid
    expect(Option.new(question: @question, name: 'Not option A', correct: false)).to be_valid
  end

  it 'requires a name' do
    expect(Option.new).to_not be_valid
    expect(Option.new(question: @question, name: 'A name')).to be_valid
  end

  it 'defaults correct to false' do
    option = Option.create(question: @question, name: 'Option A')
    expect(option.correct).to be false
  end

  it 'can generate an incorrect option' do
    incorrect = @question.options.create_incorrect_from(@question.word_under_test)
    expect(incorrect.correct).to be false
    expect(incorrect.name.length).to be > (3)
    expect(incorrect.name.length).to be < (@question.word_under_test.length + 3)
  end
end
