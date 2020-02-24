# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :sentence
  has_many :options

  before_save :assign_word_under_test

  private

  def assign_word_under_test
    if word_under_test
      unless sentence.testable_words.include?(word_under_test)
        raise 'Word under test is not a testable word'
      end

      self.word_under_test = word_under_test
    else
      self.word_under_test = sentence.testable_words.sample
    end
  end
end
