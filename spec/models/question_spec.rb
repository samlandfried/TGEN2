# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'requires a sentence' do
    expect(Question.new).to_not be_valid
    sentence = Sentence.create(original: 'New sentence')
    expect(Question.new(sentence: sentence)).to be_valid
  end
end
