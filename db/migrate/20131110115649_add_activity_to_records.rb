class AddActivityToRecords < ActiveRecord::Migration
  def change
    add_column :records, :activity, :string
  end
end
