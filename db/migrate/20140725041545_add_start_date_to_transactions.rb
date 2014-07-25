class AddStartDateToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :start_date, :date
  end
end
