class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :last_ip
      t.string :remember_token

      t.timestamps
    end
  end
end
