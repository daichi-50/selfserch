class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :image
      t.string :lost_item_category
      t.string :when
      t.string :generated_card
      t.string :user_height
      t.string :user_weight
      t.string :lost_item_description
      t.timestamps
    end
  end
end
