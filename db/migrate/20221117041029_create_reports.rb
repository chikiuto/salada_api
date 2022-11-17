class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :age
      t.string :sex
      t.string :comment, :limit => 200
      t.integer :user_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
