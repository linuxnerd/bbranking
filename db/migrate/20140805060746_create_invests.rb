class CreateInvests < ActiveRecord::Migration
  def change
    create_table :invests do |t|
      t.integer :product_id
      t.integer :user_id
      t.decimal :amount, :default => 0, :precision => 12, :scale => 2

      t.timestamps
    end
  end
end
