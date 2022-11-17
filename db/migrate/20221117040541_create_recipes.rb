class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :url
      t.string :food_image_url
      t.string :material
      t.string :cost
      t.string :indication
      
      t.timestamps
    end
  end
end
