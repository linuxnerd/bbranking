class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.date :earning_date
      t.string :seven_year_yield
      t.string :earning_per_million
      t.string :scale
      t.string :ranking
      t.integer :product_id

      t.timestamps
    end
  end
end
