class CreateConstants < ActiveRecord::Migration
  def change
    create_table :constants do |t|
      t.integer :stride
      t.integer :swim_steps_per_m
      t.integer :ride_steps_per_km

      t.timestamps
    end
  end
end
