# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sentence, type: :model do
  context 'valid Sentences' do
    it 'requires a string' do
      expect(Sentence.create).to be_invalid
      expect(Sentence.create({ original: 'Original sentence' })).to be_valid
    end
  end
end
