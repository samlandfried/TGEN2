# frozen_string_literal: true

class CreateSentences < ActiveRecord::Migration[6.0]
  def change
    create_table :sentences do |t|
      t.string :original, null: false

      t.timestamps
    end
  end
end
