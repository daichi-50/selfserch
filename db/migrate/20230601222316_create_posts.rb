class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :image
      t.string :title
      t.string :description
      t.integer :prize_money
      t.string :generated_card
      t.timestamps
    end
  end
end
