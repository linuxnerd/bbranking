class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :money_fund
      t.text :url
      t.string :code

      t.timestamps
    end
  end
end
