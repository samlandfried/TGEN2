# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe Question, :vcr, type: :model do
  it 'requires a sentence' do
    expect(Question.new).to_not be_valid
    sentence = Sentence.create(original: 'New phenomenal sentence')
    expect(Question.new(sentence: sentence)).to be_valid
  end
end
