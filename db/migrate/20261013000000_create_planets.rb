# frozen_string_literal: true

class CreatePlanets < ActiveRecord::Migration[8.1]
  def change
    create_table :planets do |t|
      t.string :name, null: false
      t.decimal :gravity, precision: 8, scale: 3, null: false

      t.timestamps
    end

    add_index :planets, :name, unique: true
  end
end
