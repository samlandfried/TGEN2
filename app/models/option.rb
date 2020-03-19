# frozen_string_literal: true

class Option < ApplicationRecord
  belongs_to :question
  validates_uniqueness_of :name
end
