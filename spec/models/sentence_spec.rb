# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe Sentence, :vcr, type: :model do
  context 'valid Sentences' do
    it 'requires an "original" field' do
      expect(Sentence.new).to be_invalid
      expect(Sentence.new({ original: 'Original sentence' })).to be_valid
    end

    it 'requires a unique "original" field' do
      expect(Sentence.create({ original: 'Original sentence anomaly' })).to be_valid
      expect(Sentence.new({ original: 'Original sentence anomaly' })).to_not be_valid
    end
  end

  context 'testability' do
    it 'marks words with low frequency as testable' do
      sentence = Sentence.create(original: 'skeptical happy eccentric common')
      expect(sentence.testable_words).to eq([0, 2])
    end

    it 'marks words longer than 3 characters as testable' do
      sentence = Sentence.create(original: 'ire scrutiny')
      expect(sentence.testable_words).to eq([1])
    end

    it 'requires a "results" field on the response to be testable' do
      sentence = Sentence.new(original: 'testable')
      expect { sentence.save }.to raise_error('Sentence has no testable words')
    end

    it 'throws if no testable words are found' do
      sentence = Sentence.new(original: 'nothing to test here')
      expect { sentence.save }.to raise_error('Sentence has no testable words')
    end
  end
end
