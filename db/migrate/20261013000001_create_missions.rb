# frozen_string_literal: true

class CreateMissions < ActiveRecord::Migration[8.1]
  def change
    create_table :missions do |t|
      t.string :name, null: false
      t.decimal :equipment_mass, precision: 15, scale: 3, null: false

      t.timestamps
    end

    add_index :missions, :name, unique: true
  end
end
