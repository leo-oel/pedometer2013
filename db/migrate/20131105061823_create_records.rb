class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :steps
      t.integer :user_id
      t.date :date
      t.string :comment

      t.timestamps
    end
    add_index :records, [:user_id, :created_at]
  end
end
