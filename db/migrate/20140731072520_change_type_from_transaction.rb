class ChangeTypeFromTransaction < ActiveRecord::Migration
  def change
    remove_column :transactions, :type
    add_column :transactions, :invest_type, :string
  end
end
