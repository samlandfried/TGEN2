# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NYT do
  it 'can get a sentence' do
    expect(NYT.get_sentence).to equal('A sentence from an NYT article')
  end
end
