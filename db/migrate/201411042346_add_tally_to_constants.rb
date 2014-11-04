class AddTallyToConstants < ActiveRecord::Migration
  def change
    add_column :constants, :tally_from, :string
    add_column :constants, :tally_to,   :string

  end
end
