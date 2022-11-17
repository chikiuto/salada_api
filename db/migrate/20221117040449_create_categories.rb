class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :category1
      t.string :category2
      t.string :category3
      t.string :category_id
      t.string :category_name
      
      t.timestamps
    end
  end
end
