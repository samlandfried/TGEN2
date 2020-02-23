# frozen_string_literal: true

class CreateSentences < ActiveRecord::Migration[6.0]
  def change
    create_table :sentences do |t|
      t.string :original, :unique

      t.timestamps
    end
  end
end
