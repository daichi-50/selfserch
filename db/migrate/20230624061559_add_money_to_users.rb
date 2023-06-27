class AddMoneyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :money, :integer, default: 0
  end
end
