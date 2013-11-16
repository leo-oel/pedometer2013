class RecordDateToRecdate < ActiveRecord::Migration
  def change
    # Record.date -> Record.recdate
    rename_column(:records, :date, :recdate)

  end
end
