class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :product_id
      t.integer :user_id
      t.decimal :amount
      t.date :earning_date

      t.timestamps
    end
  end
end
