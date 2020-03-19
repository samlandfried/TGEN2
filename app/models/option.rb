# frozen_string_literal: true

class Option < ApplicationRecord
  belongs_to :question
  validates_uniqueness_of :name, scope: :correct

  def self.create_incorrect_from(word)
    create(name: word)
  end
end
