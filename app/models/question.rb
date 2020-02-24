# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :sentence
  has_many :options

  before_create :assign_word_under_test

  private

  def assign_word_under_test
    self.word_under_test = sentence.testable_words.sample
  end
end
