# frozen_string_literal: true

class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :start_address, null: false
      t.string :end_address, null: false
      t.float :price, null: false
      t.date :delivery_date, null: false
      t.float :distance, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
