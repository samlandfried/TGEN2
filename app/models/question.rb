# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :sentence
  has_many :options
end
