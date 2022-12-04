class RenameAgeColumnToGen < ActiveRecord::Migration[7.0]
  def change
    rename_column :reports, :age, :gen
  end
end
