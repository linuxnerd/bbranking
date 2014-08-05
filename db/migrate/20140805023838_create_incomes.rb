class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :product_id
      t.integer :user_id
      t.decimal :amount, :default => 0, :precision => 12, :scale => 2
      t.date :earning_date

      t.timestamps
    end
  end
end
