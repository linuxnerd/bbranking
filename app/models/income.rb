class Income < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  after_save do
    Invest.add_to_account(amount: amount, product_id: product_id, user_id: user_id)
  end
end
