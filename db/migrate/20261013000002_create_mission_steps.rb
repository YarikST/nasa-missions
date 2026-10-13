# frozen_string_literal: true

class CreateMissionSteps < ActiveRecord::Migration[8.1]
  def change
    create_table :mission_steps do |t|
      t.references :mission, null: false, foreign_key: true
      t.references :planet, null: false, foreign_key: true
      t.string :action, null: false
      t.integer :position, null: false

      t.timestamps
    end

    add_index :mission_steps, %i[mission_id position], unique: true
  end
end
