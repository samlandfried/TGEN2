# frozen_string_literal: true

class Sentence < ApplicationRecord
  validates :original, presence: true
end
