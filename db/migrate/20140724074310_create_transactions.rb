class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount, :default => 0, :precision => 12, :scale => 2
      t.string :type
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
